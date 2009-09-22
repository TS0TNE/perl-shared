
#PASTOR: Code generated by XML::Pastor/1.0.3 at 'Wed Jul  1 15:32:04 2009'

use utf8;
use strict;
use warnings;
no warnings qw(uninitialized);

use XML::Pastor;



#================================================================

package OSCARS::Type::vlanTag;


our @ISA=qw(XML::Pastor::Builtin::string);

OSCARS::Type::vlanTag->mk_accessors( qw(_tagged));

# Attribute accessor aliases

sub tagged { &_tagged; }

OSCARS::Type::vlanTag->XmlSchemaType( bless( {
                 'attributeInfo' => {
                                    'tagged' => bless( {
                                                       'class' => 'XML::Pastor::Builtin::boolean',
                                                       'metaClass' => 'OSCARS::Pastor::Meta',
                                                       'name' => 'tagged',
                                                       'scope' => 'local',
                                                       'targetNamespace' => 'http://oscars.es.net/OSCARS',
                                                       'type' => 'boolean|http://www.w3.org/2001/XMLSchema',
                                                       'use' => 'optional'
                                                     }, 'XML::Pastor::Schema::Attribute' )
                                  },
                 'attributePrefix' => '_',
                 'attributes' => [
                                   'tagged'
                                 ],
                 'base' => 'string|http://www.w3.org/2001/XMLSchema',
                 'baseClasses' => [
                                    'XML::Pastor::Builtin::string'
                                  ],
                 'class' => 'OSCARS::Type::vlanTag',
                 'contentType' => 'complex',
                 'derivedBy' => 'extension',
                 'elementInfo' => {},
                 'elements' => [],
                 'isRedefinable' => 1,
                 'isSimpleContent' => 1,
                 'metaClass' => 'OSCARS::Pastor::Meta',
                 'name' => 'vlanTag',
                 'scope' => 'global',
                 'targetNamespace' => 'http://oscars.es.net/OSCARS'
               }, 'XML::Pastor::Schema::ComplexType' ) );

1;


__END__



=head1 NAME

B<OSCARS::Type::vlanTag>  -  A class generated by L<XML::Pastor> . 


=head1 ISA

This class descends from L<XML::Pastor::Builtin::string>.


=head1 CODE GENERATION

This module was automatically generated by L<XML::Pastor> version 1.0.3 at 'Wed Jul  1 15:32:04 2009'


=head1 ATTRIBUTE ACCESSORS

=over

=item B<_tagged>(), B<tagged>()      - See L<XML::Pastor::Builtin::boolean>.

=back


=head1 SEE ALSO

L<XML::Pastor::Builtin::string>, L<XML::Pastor>, L<XML::Pastor::Type>, L<XML::Pastor::ComplexType>, L<XML::Pastor::SimpleType>


=cut