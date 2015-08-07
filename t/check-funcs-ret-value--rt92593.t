#!/usr/bin/perl

use strict;
use warnings;

# See:
# https://rt.cpan.org/Ticket/Display.html?id=92593

use Test::More tests => 23;

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

{
    my $x = Math::GMP->new(1000 * 3);
    my $ret = $x->bgcd(1000 * 7);

    # TEST
    is ($x.'', 1000 * 3, "x did not change after x->bgcd");

    # TEST
    is ($ret.'', 1000, "ret = x->bgcd(y) is correct.");
}

{
    my $x = Math::GMP->new(1000 * 3 * 3);
    my $ret = $x->blcm(1000 * 3 * 7);

    # TEST
    is ($x.'', 1000 * 3 * 3, "x did not change after x->blcm");

    # TEST
    is ($ret.'', 1000 * 3 * 3 * 7, "ret = x->blcm(y) is correct.");
}

{
    my $x = Math::GMP->new(5);
    my $ret = $x->bmodinv(7);

    # TEST
    is ($x.'', 5, "x did not change after x->bmodinv");

    # TEST
    is ($ret.'', 3, "ret = x->bmodinv(y) is correct.");
}

{
    my $x = Math::GMP->new(6);
    my $ret = $x->bsqrt();

    # TEST
    is ($x.'', 6, "x did not change after x->bsqrt");

    # TEST
    is ($ret.'', 2, "ret = x->bsqrt() is correct.");
}

{
    my $x = Math::GMP->new(200);
    my $ret = $x->legendre(3);

    # TEST
    is ($x.'', 200, "x did not change after x->legendre");

    # TEST
    is ($ret, -1, "ret = x->legendre(y) is correct.");
}

{
    my $x = Math::GMP->new(200);
    my $ret = $x->jacobi(5);

    # TEST
    is ($x.'', 200, "x did not change after x->jacobi");

    # TEST
    is ($ret, 0, "ret = x->jacobi(y) is correct.");
}

{
    my $x = Math::GMP::fibonacci(200);

    # TEST
    is ($x.'', '280571172992510140037611932413038677189525', "Math::GMP::fibonacci() works fine");
}

{
    my $x = Math::GMP->new(7);
    my $is_prime_verdict = $x->probab_prime(10);

    # TEST
    is ($x.'', '7', "x did not change after x->probab_prime");

    # TEST
    is ($is_prime_verdict, '2', 'probab_prime works.');
}
