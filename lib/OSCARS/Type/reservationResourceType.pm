
#PASTOR: Code generated by XML::Pastor/1.0.3 at 'Wed Jul  1 15:32:04 2009'

use utf8;
use strict;
use warnings;
no warnings qw(uninitialized);

use XML::Pastor;



#================================================================

package OSCARS::Type::reservationResourceType;

use OSCARS::Type::localDetails;
use OSCARS::Type::resCreateContent;

our @ISA=qw(OSCARS::Type::resCreateContent);

OSCARS::Type::reservationResourceType->mk_accessors( qw(localDetails));

OSCARS::Type::reservationResourceType->XmlSchemaType( bless( {
                 'attributeInfo' => {},
                 'attributePrefix' => '_',
                 'attributes' => [],
                 'base' => 'resCreateContent|http://oscars.es.net/OSCARS',
                 'baseClasses' => [
                                    'OSCARS::Type::resCreateContent'
                                  ],
                 'class' => 'OSCARS::Type::reservationResourceType',
                 'contentType' => 'complex',
                 'derivedBy' => 'extension',
                 'elementInfo' => {
                                  'localDetails' => bless( {
                                                           'class' => 'OSCARS::Type::localDetails',
                                                           'metaClass' => 'OSCARS::Pastor::Meta',
                                                           'minOccurs' => '0',
                                                           'name' => 'localDetails',
                                                           'scope' => 'local',
                                                           'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                           'type' => 'localDetails|http://oscars.es.net/OSCARS'
                                                         }, 'XML::Pastor::Schema::Element' )
                                },
                 'elements' => [
                                 'localDetails'
                               ],
                 'isRedefinable' => 1,
                 'metaClass' => 'OSCARS::Pastor::Meta',
                 'name' => 'reservationResourceType',
                 'scope' => 'global',
                 'targetNamespace' => 'http://oscars.es.net/OSCARS',
                 'xElementInfo' => {
                                     'bandwidth' => bless( {
                                                           'class' => 'XML::Pastor::Builtin::int',
                                                           'metaClass' => 'OSCARS::Pastor::Meta',
                                                           'name' => 'bandwidth',
                                                           'scope' => 'local',
                                                           'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                           'type' => 'int|http://www.w3.org/2001/XMLSchema'
                                                         }, 'XML::Pastor::Schema::Element' ),
                                     'description' => bless( {
                                                             'class' => 'XML::Pastor::Builtin::string',
                                                             'metaClass' => 'OSCARS::Pastor::Meta',
                                                             'name' => 'description',
                                                             'scope' => 'local',
                                                             'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                             'type' => 'string|http://www.w3.org/2001/XMLSchema'
                                                           }, 'XML::Pastor::Schema::Element' ),
                                     'endTime' => bless( {
                                                         'class' => 'XML::Pastor::Builtin::long',
                                                         'metaClass' => 'OSCARS::Pastor::Meta',
                                                         'name' => 'endTime',
                                                         'scope' => 'local',
                                                         'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                         'type' => 'long|http://www.w3.org/2001/XMLSchema'
                                                       }, 'XML::Pastor::Schema::Element' ),
                                     'globalReservationId' => bless( {
                                                                     'class' => 'XML::Pastor::Builtin::string',
                                                                     'maxOccurs' => '1',
                                                                     'metaClass' => 'OSCARS::Pastor::Meta',
                                                                     'minOccurs' => '0',
                                                                     'name' => 'globalReservationId',
                                                                     'scope' => 'local',
                                                                     'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                                     'type' => 'string|http://www.w3.org/2001/XMLSchema'
                                                                   }, 'XML::Pastor::Schema::Element' ),
                                     'localDetails' => bless( {
                                                              'class' => 'OSCARS::Type::localDetails',
                                                              'metaClass' => 'OSCARS::Pastor::Meta',
                                                              'minOccurs' => '0',
                                                              'name' => 'localDetails',
                                                              'scope' => 'local',
                                                              'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                              'type' => 'localDetails|http://oscars.es.net/OSCARS'
                                                            }, 'XML::Pastor::Schema::Element' ),
                                     'pathInfo' => bless( {
                                                          'class' => 'OSCARS::Type::pathInfo',
                                                          'metaClass' => 'OSCARS::Pastor::Meta',
                                                          'name' => 'pathInfo',
                                                          'scope' => 'local',
                                                          'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                          'type' => 'pathInfo|http://oscars.es.net/OSCARS'
                                                        }, 'XML::Pastor::Schema::Element' ),
                                     'startTime' => bless( {
                                                           'class' => 'XML::Pastor::Builtin::long',
                                                           'metaClass' => 'OSCARS::Pastor::Meta',
                                                           'name' => 'startTime',
                                                           'scope' => 'local',
                                                           'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                           'type' => 'long|http://www.w3.org/2001/XMLSchema'
                                                         }, 'XML::Pastor::Schema::Element' )
                                   },
                 'xElements' => [
                                  'globalReservationId',
                                  'startTime',
                                  'endTime',
                                  'bandwidth',
                                  'description',
                                  'pathInfo',
                                  'localDetails'
                                ]
               }, 'XML::Pastor::Schema::ComplexType' ) );

1;


__END__



=head1 NAME

B<OSCARS::Type::reservationResourceType>  -  A class generated by L<XML::Pastor> . 


=head1 ISA

This class descends from L<OSCARS::Type::resCreateContent>.


=head1 CODE GENERATION

This module was automatically generated by L<XML::Pastor> version 1.0.3 at 'Wed Jul  1 15:32:04 2009'


=head1 CHILD ELEMENT ACCESSORS

=over

=item B<localDetails>()      - See L<OSCARS::Type::localDetails>.

=back


=head1 SEE ALSO

L<OSCARS::Type::resCreateContent>, L<XML::Pastor>, L<XML::Pastor::Type>, L<XML::Pastor::ComplexType>, L<XML::Pastor::SimpleType>


=cut