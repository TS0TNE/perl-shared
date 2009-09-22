
#PASTOR: Code generated by XML::Pastor/1.0.3 at 'Wed Jul  1 15:32:04 2009'

use utf8;
use strict;
use warnings;
no warnings qw(uninitialized);

use XML::Pastor;



#================================================================

package OSCARS::Type::forwardPayload;

use OSCARS::Type::createPathContent;
use OSCARS::Type::globalReservationId;
use OSCARS::Type::listRequest;
use OSCARS::Type::modifyResContent;
use OSCARS::Type::refreshPathContent;
use OSCARS::Type::resCreateContent;
use OSCARS::Type::teardownPathContent;

our @ISA=qw(XML::Pastor::ComplexType);

OSCARS::Type::forwardPayload->mk_accessors( qw(contentType createReservation modifyReservation cancelReservation queryReservation listReservations createPath refreshPath teardownPath));

OSCARS::Type::forwardPayload->XmlSchemaType( bless( {
                 'attributeInfo' => {},
                 'attributePrefix' => '_',
                 'attributes' => [],
                 'baseClasses' => [
                                    'XML::Pastor::ComplexType'
                                  ],
                 'class' => 'OSCARS::Type::forwardPayload',
                 'contentType' => 'complex',
                 'elementInfo' => {
                                  'cancelReservation' => bless( {
                                                                'class' => 'OSCARS::Type::globalReservationId',
                                                                'maxOccurs' => '1',
                                                                'metaClass' => 'OSCARS::Pastor::Meta',
                                                                'minOccurs' => '0',
                                                                'name' => 'cancelReservation',
                                                                'scope' => 'local',
                                                                'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                                'type' => 'globalReservationId|http://oscars.es.net/OSCARS'
                                                              }, 'XML::Pastor::Schema::Element' ),
                                  'contentType' => bless( {
                                                          'class' => 'XML::Pastor::Builtin::string',
                                                          'metaClass' => 'OSCARS::Pastor::Meta',
                                                          'name' => 'contentType',
                                                          'scope' => 'local',
                                                          'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                          'type' => 'string|http://www.w3.org/2001/XMLSchema'
                                                        }, 'XML::Pastor::Schema::Element' ),
                                  'createPath' => bless( {
                                                         'class' => 'OSCARS::Type::createPathContent',
                                                         'maxOccurs' => '1',
                                                         'metaClass' => 'OSCARS::Pastor::Meta',
                                                         'minOccurs' => '0',
                                                         'name' => 'createPath',
                                                         'scope' => 'local',
                                                         'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                         'type' => 'createPathContent|http://oscars.es.net/OSCARS'
                                                       }, 'XML::Pastor::Schema::Element' ),
                                  'createReservation' => bless( {
                                                                'class' => 'OSCARS::Type::resCreateContent',
                                                                'maxOccurs' => '1',
                                                                'metaClass' => 'OSCARS::Pastor::Meta',
                                                                'minOccurs' => '0',
                                                                'name' => 'createReservation',
                                                                'scope' => 'local',
                                                                'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                                'type' => 'resCreateContent|http://oscars.es.net/OSCARS'
                                                              }, 'XML::Pastor::Schema::Element' ),
                                  'listReservations' => bless( {
                                                               'class' => 'OSCARS::Type::listRequest',
                                                               'maxOccurs' => '1',
                                                               'metaClass' => 'OSCARS::Pastor::Meta',
                                                               'minOccurs' => '0',
                                                               'name' => 'listReservations',
                                                               'scope' => 'local',
                                                               'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                               'type' => 'listRequest|http://oscars.es.net/OSCARS'
                                                             }, 'XML::Pastor::Schema::Element' ),
                                  'modifyReservation' => bless( {
                                                                'class' => 'OSCARS::Type::modifyResContent',
                                                                'maxOccurs' => '1',
                                                                'metaClass' => 'OSCARS::Pastor::Meta',
                                                                'minOccurs' => '0',
                                                                'name' => 'modifyReservation',
                                                                'scope' => 'local',
                                                                'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                                'type' => 'modifyResContent|http://oscars.es.net/OSCARS'
                                                              }, 'XML::Pastor::Schema::Element' ),
                                  'queryReservation' => bless( {
                                                               'class' => 'OSCARS::Type::globalReservationId',
                                                               'maxOccurs' => '1',
                                                               'metaClass' => 'OSCARS::Pastor::Meta',
                                                               'minOccurs' => '0',
                                                               'name' => 'queryReservation',
                                                               'scope' => 'local',
                                                               'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                               'type' => 'globalReservationId|http://oscars.es.net/OSCARS'
                                                             }, 'XML::Pastor::Schema::Element' ),
                                  'refreshPath' => bless( {
                                                          'class' => 'OSCARS::Type::refreshPathContent',
                                                          'maxOccurs' => '1',
                                                          'metaClass' => 'OSCARS::Pastor::Meta',
                                                          'minOccurs' => '0',
                                                          'name' => 'refreshPath',
                                                          'scope' => 'local',
                                                          'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                          'type' => 'refreshPathContent|http://oscars.es.net/OSCARS'
                                                        }, 'XML::Pastor::Schema::Element' ),
                                  'teardownPath' => bless( {
                                                           'class' => 'OSCARS::Type::teardownPathContent',
                                                           'maxOccurs' => '1',
                                                           'metaClass' => 'OSCARS::Pastor::Meta',
                                                           'minOccurs' => '0',
                                                           'name' => 'teardownPath',
                                                           'scope' => 'local',
                                                           'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                           'type' => 'teardownPathContent|http://oscars.es.net/OSCARS'
                                                         }, 'XML::Pastor::Schema::Element' )
                                },
                 'elements' => [
                                 'contentType',
                                 'createReservation',
                                 'modifyReservation',
                                 'cancelReservation',
                                 'queryReservation',
                                 'listReservations',
                                 'createPath',
                                 'refreshPath',
                                 'teardownPath'
                               ],
                 'isRedefinable' => 1,
                 'metaClass' => 'OSCARS::Pastor::Meta',
                 'name' => 'forwardPayload',
                 'scope' => 'global',
                 'targetNamespace' => 'http://oscars.es.net/OSCARS'
               }, 'XML::Pastor::Schema::ComplexType' ) );

1;


__END__



=head1 NAME

B<OSCARS::Type::forwardPayload>  -  A class generated by L<XML::Pastor> . 


=head1 ISA

This class descends from L<XML::Pastor::ComplexType>.


=head1 CODE GENERATION

This module was automatically generated by L<XML::Pastor> version 1.0.3 at 'Wed Jul  1 15:32:04 2009'


=head1 CHILD ELEMENT ACCESSORS

=over

=item B<cancelReservation>()      - See L<OSCARS::Type::globalReservationId>.

=item B<contentType>()      - See L<XML::Pastor::Builtin::string>.

=item B<createPath>()      - See L<OSCARS::Type::createPathContent>.

=item B<createReservation>()      - See L<OSCARS::Type::resCreateContent>.

=item B<listReservations>()      - See L<OSCARS::Type::listRequest>.

=item B<modifyReservation>()      - See L<OSCARS::Type::modifyResContent>.

=item B<queryReservation>()      - See L<OSCARS::Type::globalReservationId>.

=item B<refreshPath>()      - See L<OSCARS::Type::refreshPathContent>.

=item B<teardownPath>()      - See L<OSCARS::Type::teardownPathContent>.

=back


=head1 SEE ALSO

L<XML::Pastor::ComplexType>, L<XML::Pastor>, L<XML::Pastor::Type>, L<XML::Pastor::ComplexType>, L<XML::Pastor::SimpleType>


=cut