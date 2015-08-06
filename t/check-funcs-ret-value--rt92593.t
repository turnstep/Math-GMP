#!/usr/bin/perl

use strict;
use warnings;

# See:
# https://rt.cpan.org/Ticket/Display.html?id=92593

use Test::More tests => 2;

use Math::GMP;

{
    my $x = Math::GMP->new(5);
    my $val = $x->bfac();      # 1*2*3*4*5 = 120

    # TEST
    is ($x.'', "5", "x->bfac did not change x");

    # TEST
    is ($val.'', '120', 'val=x->bfac is correct.');
}

