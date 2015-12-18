package perfSONAR_PS::NPToolkit::DataService::RegularTesting;

use strict;
use warnings;

use Params::Validate qw(:all);
use Data::Dumper;
use JSON;

use base 'perfSONAR_PS::NPToolkit::DataService::BaseConfig';

# BEGIN use statements copied from old regular testing

use CGI qw/:standard/;
use CGI::Carp qw(fatalsToBrowser);
use CGI::Ajax;
use CGI::Session;
use Template;
use Template::Filters;
use Config::General;
use Log::Log4perl qw(get_logger :easy :levels);
use Net::IP;
use Params::Validate;
use Storable qw(store retrieve freeze thaw dclone);

use perfSONAR_PS::Utils::DNS qw( reverse_dns resolve_address reverse_dns_multi resolve_address_multi );
use perfSONAR_PS::Utils::Host qw( get_ethernet_interfaces get_interface_addresses discover_primary_address );
use perfSONAR_PS::Client::gLS::Keywords;
#use perfSONAR_PS::NPToolkit::Config::AdministrativeInfo;
use perfSONAR_PS::NPToolkit::Config::BWCTL;
use perfSONAR_PS::NPToolkit::Config::RegularTesting;
use perfSONAR_PS::Common qw(find findvalue extract genuid);
use perfSONAR_PS::Web::Sidebar qw(set_sidebar_vars);

use Data::Validate::IP qw(is_ipv4);
use Data::Validate::Domain qw(is_hostname);
use Net::IP;
use Time::HiRes qw( time );

use JSON qw(from_json);

sub new {

    my ( $class, @params ) = @_;

    my $self = fields::new( $class );

    $self->{LOGGER} = get_logger( $class );

    my $regular_testing_conf = perfSONAR_PS::NPToolkit::Config::RegularTesting->new();
    $regular_testing_conf->init();
    $self->{regular_testing_conf} = $regular_testing_conf;

    return $self;

}

# END use statements from old regular testing
sub add_test_configuration {

    my $self = shift;
    my $caller = shift;
    my $input_data = $caller->{'input_params'}->{'POSTDATA'};
    my $json_text = $input_data->{'value'};

    my $data = from_json($json_text);

    my @result=[];
    my $ret_val=-1;

    my $regular_testing_conf = $self->{regular_testing_conf};

    if($data){

        my $tests = $data->{'data'};

        if($tests){

            foreach my $test (@{$tests}){

                my $test_type =  $test->{'type'};
                my $parameters =  $test->{'parameters'};
                my $disabled = $test->{'disabled'};
                my $description = $test->{'description'};
                my $members = $test->{'members'};
                
                my $test_id;
                if($test_type eq 'owamp'){

                    $test_id = $regular_testing_conf->add_test_owamp($parameters);

                }elsif($test_type eq 'bwctl'){

                    $test_id = $regular_testing_conf->add_test_bwctl_throughput($parameters);

                }elsif($test_type eq 'pinger'){

                    $test_id = $regular_testing_conf->add_test_pinger($parameters);

                }elsif($test_type eq 'traceroute'){
                    $test_id = $regular_testing_conf->add_test_traceroute($parameters);

                }

                if($test_id){
                    foreach my $member (@{$members}){
                        $member->{'test_id'} = $test_id;
                        my $ret = $regular_testing_conf->add_test_member($member);

                    }
                push @result, $test;
                    
                }

            }  
        } 
        
    }

    my $response = ();
    if(@result){
        my ($ret_val, $ret_message) = $regular_testing_conf->save();
        $response->{"tests_added"} = \@result;
        $response->{"Config saved to disk"}= $ret_val;
        $response->{"Error message"}= $ret_message;

    }else{
        $response->{"Config saved to disk"}= -1;
        $response->{"Error message"}= "Error adding tests";
        $response->{"tests_added"} = \@result;
    }

    
    return $response;

}

sub get_test_configuration {
    my $self = shift;
    my $testing_conf = $self->{regular_testing_conf};

    if ($self->{load_regular_testing} != 1) {
        return {error => "Regular testing config must be loaded before getting test configuration"};
    }

    my $tests = [];
    my ( $status, $res ) = $testing_conf->get_tests();
    if ( $status == 0 ) {
        $tests = $res;
    } else {
        $tests = [];
    }

    my @sorted_tests = sort { $a->{description} cmp $b->{description} } @$tests;
    $tests = \@sorted_tests;

    foreach my $test (@$tests) {
        my $test_id = $test->{id};
        $test_id =~ s/test\.//g;
        $test->{test_id} = $test_id;

        
        my $current_test = $test_id;
        # This next line seems unnecessary. TODO: remove entirely (lookup_test)
        #my ( $status, $res ) = $testing_conf->lookup_test( { test_id => $current_test } );

        foreach my $member (@{ $test->{members} }) {
            my $member_id = $member->{id};
            $member_id =~ s/member\.//g;
            $member->{member_id} = $member_id;
        }

        # Skip the below section for now        
        next;

        # NOTE: This part seems unnecessary

        if ( $status != 0 ) {
            $self->{LOGGER}->info( "Failed to lookup test " . $current_test ) unless ( $status == 0 );
        } else {

            $self->{LOGGER}->info( "Succeeded looking up test " . $current_test );
            my $test_id = $res->{id};
            $test_id =~ s/test\.//g;
            $res->{id_num} = $test_id;

            # Check whether or not the test members can do ipv4 or ipv6 tests
            foreach my $member (@{ $res->{members} }) {
                next if ($member->{can_test_ipv4} or $member->{can_test_ipv6});


                my $addr = $member->{address};

                my ($ipv4, $ipv6) = (0, 0);

                # Discover the hostname, and figure out if ipv4 or ipv6 testing should
                # be done.
                if ( is_ipv4( $addr ) ) {
                    $ipv4 = 1;
                }
                elsif ( &Net::IP::ip_is_ipv6( $addr ) ) {
                    $ipv6 = 1;
                }
                elsif ( is_hostname( $addr ) ) {
                    my @host_addrs = resolve_address($addr);
                    foreach my $host_addr (@host_addrs) {
                        if ( &Net::IP::ip_is_ipv6( $host_addr ) ) {
                            $ipv6 = 1;
                        }
                        elsif ( is_ipv4( $host_addr ) ) {
                            $ipv4 = 1;
                        }
                    }

                    if (scalar(@host_addrs) == 0) {
                        $ipv6 = 1;
                        $ipv4 = 1;
                    }
                }

                $member->{can_test_ipv4} = $ipv4;
                $member->{can_test_ipv6} = $ipv6;

                # The template assumes that test_ipv4/test_ipv6 are either 1 or
                # 0, not undef.
                $member->{test_ipv4} = 0 unless $member->{test_ipv4};
                $member->{test_ipv6} = 0 unless $member->{test_ipv6};
            }
        }
    }

    my $status_vars = $self->get_status($tests);

    return {
        test_configuration => $tests,
        status => $status_vars,
    };
}

sub get_status {
    my ( $self, $tests ) = @_;
    my $testing_conf = $self->{regular_testing_conf};
    
    # Calculates whether or not they have a "good" configuration

    my ($status, $res);
    my $status_vars = {};

    my $hosts_file_matches_dns;

    my $psb_throughput_tests = 0;
    my $pinger_tests         = 0;
    my $psb_owamp_tests      = 0;
    my $network_usage        = 0;
    my $owamp_port_usage     = 0;
    my $bwctl_port_usage     = 0;
    my $traceroute_tests     = 0;

    my $bwctl_conf = perfSONAR_PS::NPToolkit::Config::BWCTL->new();
    # TODO: make bwctld config file paths configurable
    ( $status, $res ) = $bwctl_conf->init(  );
    #( $status, $res ) = $bwctl_conf->init( { bwctld_limits => $conf{bwctld_limits}, bwctld_conf => $conf{bwctld_conf}, bwctld_keys => $conf{bwctld_keys} } );

        foreach my $test ( @{$tests} ) {
            if ( $test->{type} eq "bwctl/throughput" ) {
                $psb_throughput_tests++;
            }
            elsif ( $test->{type} eq "pinger" ) {
                $pinger_tests++;
            }
            elsif ( $test->{type} eq "owamp" ) {
                $psb_owamp_tests++;
            }
            elsif ( $test->{type} eq "traceroute" ) {
                $traceroute_tests++;
            }

            if ( $test->{type} eq "owamp" ) {
                foreach my $member ( @{ $test->{members} } ) {
                    if ( $member->{sender} ) {
                        $owamp_port_usage += 2;
                    }
                    if ( $member->{receiver} ) {
                        $owamp_port_usage += 2;
                    }
                }
            }

            if ( $test->{type} eq "bwctl/throughput" ) {
                my $test_duration = $test->{parameters}->{duration};
                my $test_interval = $test->{parameters}->{test_interval};

                my $num_tests = 0;
                foreach my $member ( @{ $test->{members} } ) {
                    if ( $member->{sender} ) {
                        $bwctl_port_usage += 2;
                        $num_tests++;
                    }
                    if ( $member->{receiver} ) {
                        $bwctl_port_usage += 2;
                        $num_tests++;
                    }
                }

                # Add 15 seconds onto the duration to account for synchronization issues
                $test_duration += 15;

                $network_usage += ( $num_tests * $test_duration ) / $test_interval if ($test_interval > 0);
            }
        }

    # "merge" the two bwctl port ranges
    my %bwctl_ports = ();
    my $bwctl_port_range;

    ($status, $res) = $bwctl_conf->get_port_range({ port_type => "peer" });
    if ($status == 0) {
        if ($res->{min_port} and $res->{max_port}) {
            $bwctl_ports{min_port} = $res->{min_port};
            $bwctl_ports{max_port} = $res->{max_port};
        }
    }

    ($status, $res) = $bwctl_conf->get_port_range({ port_type => "iperf" });
    if ($status == 0) {
        if ($res->{min_port} and $res->{max_port}) {
            $bwctl_ports{min_port} = ($bwctl_ports{min_port} and $bwctl_ports{min_port} < $res->{min_port})?$bwctl_ports{min_port}:$res->{min_port};
            $bwctl_ports{max_port} = ($bwctl_ports{max_port} and $bwctl_ports{max_port} > $res->{max_port})?$bwctl_ports{max_port}:$res->{max_port};
        }
    }

    if (defined $bwctl_ports{min_port} and defined $bwctl_ports{max_port}) {
        $bwctl_port_range = $bwctl_ports{max_port} - $bwctl_ports{min_port} + 1;
    }

    my %owamp_ports = ();
    my $owamp_port_range;

    ($status, $res) = $testing_conf->get_local_port_range({ test_type => "owamp" });
    if ($status == 0) {
        if ($res) {
            $owamp_ports{min_port} = $res->{min_port};
            $owamp_ports{max_port} = $res->{max_port};
        }
    }

    if (defined $owamp_ports{min_port} and defined $owamp_ports{max_port}) {
        $owamp_port_range = $owamp_ports{max_port} - $owamp_ports{min_port} + 1;
    }

    $status_vars->{network_percent_used}    = sprintf "%.1d", $network_usage * 100;
    $status_vars->{bwctl_ports}             = \%bwctl_ports;
    $status_vars->{bwctl_port_range}        = $bwctl_port_range;
    $status_vars->{bwctl_port_usage}        = $bwctl_port_usage;
    $status_vars->{hosts_file_matches_dns} = $hosts_file_matches_dns;
    $status_vars->{owamp_ports}             = \%owamp_ports;
    $status_vars->{owamp_port_range}        = $owamp_port_range;
    $status_vars->{owamp_port_usage}        = $owamp_port_usage;
    $status_vars->{owamp_tests}             = $psb_owamp_tests;
    $status_vars->{pinger_tests}            = $pinger_tests;
    $status_vars->{throughput_tests}        = $psb_throughput_tests;
    $status_vars->{traceroute_tests}        = $traceroute_tests;

    return $status_vars;
}


1;

# vim: expandtab shiftwidth=4 tabstop=4
