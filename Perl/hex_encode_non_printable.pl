#!/usr/bin/env perl

use strict;
use warnings;

use feature q{say};

=pod

Useful script to output chars in non free form hex where not printable.
Particularly useful for debugging where hashed strings are being compared.

=cut

sub hex_encode {
    my $str = shift;
    my @res;
    my @chars = split q{},$str;

    foreach my $char (@chars) {
        if ( $char =~ /[\c@-\c_]/ || $char =~ /[^[:ascii:]]/ ) {

            my $nchar = sprintf(qq{%02x}, ord($char));
            $nchar = q{\x} . $nchar;
            push @res, $nchar;
        }
        else {
            push @res, $char;
        }
    }

    my $res = join q{}, @res;
    return $res;
}

say hex_encode(qq{\tstring\n});