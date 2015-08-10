package perfSONAR_PS::NPToolkit::DataService::NTP;
use fields qw( LOGGER config config_file ntp ntp_conf failed_connect );
use strict;
use warnings;

use Log::Log4perl qw(get_logger :easy :levels);
use POSIX;
use Data::Dumper;
use Params::Validate qw(:all);
use Net::IP;

use Data::Validate::IP qw(is_ipv4);

#use perfSONAR_PS::NPToolkit::ConfigManager::Utils qw( save_file start_service restart_service stop_service );
use perfSONAR_PS::Utils::DNS qw( reverse_dns resolve_address );
use perfSONAR_PS::NPToolkit::Config::NTP;
use perfSONAR_PS::NPToolkit::Services::ServicesMap qw(get_service_object);
use perfSONAR_PS::Utils::Host qw(get_ntp_info);


sub new {
    my ( $class, @params ) = @_;

    my $self = fields::new( $class );

    $self->{LOGGER} = get_logger( $class );
    my $parameters = validate(
        @params,
        {
            config_file => 1
        }
    );
    $self->{config_file} = $parameters->{config_file};
    my $config = Config::General->new( -ConfigFile => $self->{config_file} );
    $self->{config} = { $config->getall() };
    my $ntp = get_service_object("ntp");
    my $ntp_conf = perfSONAR_PS::NPToolkit::Config::NTP->new();
    $ntp_conf->init( { ntp_conf => $config->{ntp_conf} } );
    $self->{ntp_conf} = $ntp_conf;
    $self->{failed_connect} = {};

    return $self;
}

sub get_ntp_information {
    
    my $self = shift;
    my $response = get_ntp_info();
    return $response;

}

sub get_ntp_configuration {

}

sub get_selected_servers {
    my $self = shift;
    my $ntp_conf = $self->{ntp_conf};
    my $ntp_servers = $ntp_conf->get_selected_servers( { as_hash => 1 });
    my $vars_servers = $self->_format_servers($ntp_servers);
    return $vars_servers
}

sub get_known_servers {
    my $self = shift;
    my $ntp_conf = $self->{ntp_conf};

    my $ntp_servers = $ntp_conf->get_servers();
    my $vars_servers = $self->_format_servers($ntp_servers);
    return $vars_servers;
}

sub _format_servers {
    my ($self, $ntp_servers) = @_;
    my @vars_servers = ();
    my $failed_connect = $self->{failed_connect};
    foreach my $key ( sort { $ntp_servers->{$a}->{description} cmp $ntp_servers->{$b}->{description} } keys %{$ntp_servers} ) {
        my $ntp_server = $ntp_servers->{$key};

        my $display_address = $ntp_server->{address};
        if ( is_ipv4( $display_address ) or &Net::IP::ip_is_ipv6( $display_address ) ) {
            my $new_addr = reverse_dns( $display_address );
	    $display_address = $new_addr if ($new_addr);
        }

        my %server_info = (
            address         => $ntp_server->{address},
            display_address => $display_address,
            description     => $ntp_server->{description},
            selected        => $ntp_server->{selected},
	        #failed_connect  => $failed_connect->{$ntp_server->{address}},
        );

        push @vars_servers, \%server_info;
    }
    return \@vars_servers;


}

sub find_closest_servers {
    my ($self, @params) = @_;
    my $parameters = validate(
        @params,
        {
            servers        => 1,
            maximum_number => 0,
        }
    );
    my $servers = $parameters->{servers};
    my $maximum_number = $parameters->{maximum_number};

    my ( $status, $results ) = ping({ hostnames => $servers, timeout => 60 });
    my @failed_hosts = ();
    my @succeeded_hosts = ();

    foreach my $host (keys %$results) {
        if ($results->{$host}->{rtt}) {
            push @succeeded_hosts, { address => $host, rtt => $results->{$host}->{rtt} };
        }
        else {
            push @failed_hosts, $host;
        }
    }

    @succeeded_hosts = sort { $a->{rtt} <=> $b->{rtt} } @succeeded_hosts;

    # make sure we only grab the maximum number

    if ( $parameters->{maximum_number} && scalar(@succeeded_hosts) > $parameters->{maximum_number}) {
        splice @succeeded_hosts, $maximum_number;
    }

    return ( 0, \@succeeded_hosts, \@failed_hosts );
}

sub add_server {
    my $self = shift;
    my $caller = shift;
    my $params = $caller->{'input_params'};

    #my ( $self, $address, $description, $selected ) = @_;
    my $address = $params->{'address'}->{'value'};
    my $description = $params->{'description'}->{'value'};
    my $ntp_conf = $self->{ntp_conf};

    if ( $ntp_conf->lookup_server( { address => $address } ) ) {
    	my $error_msg = "Server $address already exists";
        return { "error" => $error_msg };
    }

    $ntp_conf->add_server(
        {
            address     => $address,
            description => $description,
            selected    => 1,
        }
    );
    #$is_modified = 1;

    #save_state();

    #$self->{logger}->info( "Server $address added" );

    my $status_msg = "Server $address added";

    #return { "message" => $status_msg };
    return $self->save_config();
}

sub delete_server {
    my $self = shift;
    my $caller = shift;
    my $address = $caller->{'input_params'}->{'address'}->{'value'};
    #$logger->info( "Deleting Server: $address" );

    $self->{'ntp_conf'}->delete_server( { address => $address } );

    #$is_modified = 1;

    #save_state();

    my $status_msg = "Server $address deleted";
    #return { message => $status_msg };
    return $self->save_config();
    #return display_body();
}

sub enable_server {
    my $self = shift;
    my $caller = shift;
    my $address = $caller->{'input_params'}->{'address'}->{'value'};
    my $state = 'enabled';

    return $self->_set_server_state($address, $state);
}

sub disable_server {
    my $self = shift;
    my $caller = shift;
    my $address = $caller->{'input_params'}->{'address'}->{'value'};
    my $state = 'disabled';

    return $self->_set_server_state($address, $state);
}

sub _set_server_state {
    my ($self, $address, $state) = @_;

    my $ntp_conf = $self->{'ntp_conf'};

    #$logger->info( "Toggling server $address" );

    return unless ( $ntp_conf->lookup_server( { address => $address } ) );

    if ( $state and $state eq "on" ) {
        $status_msg = "Server $address selected";
        #$logger->info( "Enabling server $address: '$state'" );
        $ntp_conf->update_server( { address => $address, selected => 1 } );
    }
    else {
        $logger->info( "Disabling server $address: '$state'" );
        #$status_msg = "Server $address unselected";
        $ntp_conf->update_server( { address => $address, selected => 0 } );
    }

    #$is_modified = 1;

    #save_state();

    #return display_body();
    return $self->save_config();
}

sub save_config {
    my $self = shift;
    my ($status, $res) = $self->{'ntp_conf'}->save( { restart_services => 1 } );
    if ($status != 0) {
        return { error_msg => "Problem saving configuration: $res" };
    } else {
        return { message => "Configuration Saved And Services Restarted" };
        #$is_modified = 0;
        #$initial_state_time = $ntp_conf->last_modified();
    }
 
    #save_state();
    #
    #return display_body();
}


1;

# vim: expandtab shiftwidth=4 tabstop=4
