package SimpleLookupService::Records::Directory::Person;

=head1 NAME

SimpleLookupService::Records::Network::Interface - Class that deals records that are network interfaces

=head1 DESCRIPTION

A base class for network interface. it defines fields like interface-name, address, mac address, capacity, etc.

=cut

use strict;
use warnings;

our $VERSION = 3.2;

use base 'SimpleLookupService::Records::Record';

use Params::Validate qw( :all );
use JSON qw( encode_json decode_json);

sub init {
    my ( $self, @args ) = @_;
    my %parameters = validate( @args, {personName => 1, personEmails => 1 } );
    
    $self->SUPER::init(type=>(SimpleLookupService::Keywords::Values::LS_VALUE_TYPE_PERSON)); 
    
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_NAME), value=>$parameters{personName});
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_EMAILS), value=>$parameters{personEmails});
    
    return 0;
}

sub getPersonName {
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_NAME)};
}

sub setPersonName {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_NAME), value=>$value  );
    
}

sub getEmailAddresses {
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_EMAILS)};
}

sub setEmailAddresses {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_EMAILS), value=>$value  );
    
}

sub getPhoneNumbers {
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_PHONENUMBERS)};
}

sub setPhoneNumbers {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_PHONENUMBERS), value=>$value  );
    
}

sub getOrganization {
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_ORGANIZATION)};
}

sub setOrganization {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_PERSON_ORGANIZATION), value=>$value  );
    
}

sub getSiteName{
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_SITENAME)};
}

sub setSiteName {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_SITENAME), value=>$value  );
    
}    

sub getCity{
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_CITY)};
}

sub setCity {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_CITY), value=>$value  );
    
}

sub getRegion{
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_STATE)};
}

sub setRegion {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_STATE), value=>$value  );
    
}

sub getCountry{
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_COUNTRY)};
}

sub setCountry {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_COUNTRY), value=>$value  );
    
}

sub getZipCode{
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_CODE)};
}

sub setZipCode {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_CODE), value=>$value  );
    
}

sub getLatitude{
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_LATITUDE)};
}

sub setLatitude {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_LATITUDE), value=>$value  );
    
}

sub getLongitude{
    my $self = shift;
    return $self->{RECORD_HASH}->{(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_LONGITUDE)};
}

sub setLongitude {
    my ( $self, $value ) = @_;
    $self->SUPER::addField(key=>(SimpleLookupService::Keywords::KeyNames::LS_KEY_LOCATION_LONGITUDE), value=>$value  );
    
}
1;