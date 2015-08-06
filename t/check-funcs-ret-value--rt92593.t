#!/usr/bin/perl

use strict;
use warnings;

# See:
# https://rt.cpan.org/Ticket/Display.html?id=92593

use Test::More tests => 8;

use Math::GMP;

{
    my $x = Math::GMP->new(5);
    my $val = $x->bfac();      # 1*2*3*4*5 = 120

    # TEST
    is ($x.'', "5", "x->bfac did not change x");

    # TEST
    is ($val.'', '120', 'val=x->bfac is correct.');
}

{
    my $x = Math::GMP->new(0b1100);
    my $ret = $x->band(0b1010, 0);

    # TEST
    is ($x.'', 0b1100, "x->band did not change");

    # TEST
    is ($ret.'', 0b1000, "ret = x->band is correct.");
}

{
    my $x = Math::GMP->new(0b1100);
    my $ret = $x->bxor(0b1010, 0);

    # TEST
    is ($x.'', 0b1100, "x did not change after x->bxor");

    # TEST
    is ($ret.'', 0b110, "ret = x->bxor is correct.");
}

{
    my $x = Math::GMP->new(0b1100);
    my $ret = $x->bior(0b1010, 0);

    # TEST
    is ($x.'', 0b1100, "x did not change after x->bior");

    # TEST
    is ($ret.'', 0b1110, "ret = x->bior is correct.");
}
