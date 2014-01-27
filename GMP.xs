#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "gmp.h"

/*
Math::GMP, a Perl module for high-speed arbitrary size integer
calculations
Copyright (C) 2000 James H. Turner

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with this library; if not, write to the Free
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

You can contact the author at chip@redhat.com, chipt@cpan.org, or by mail:

Chip Turner
Red Hat Inc.
2600 Meridian Park Blvd
Durham, NC 27713
*/

static int
not_here(char *s)
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant(char *name, int arg)
{
    errno = 0;
    switch (*name) {
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}


MODULE = Math::GMP		PACKAGE = Math::GMP		
PROTOTYPES: ENABLE


double
constant(name,arg)
	char *		name
	int		arg

mpz_t *
new_from_scalar(s)
	char *	s

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init_set_str(*RETVAL, s, 0);
  OUTPUT:
    RETVAL

mpz_t *
new_from_scalar_with_base(s, b)
        char *  s
        int b

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init_set_str(*RETVAL, s, b);
  OUTPUT:
    RETVAL

void
destroy(n)
	mpz_t *n

  CODE:
    mpz_clear(*n);
    free(n);

SV *
stringify_gmp(n)
	mpz_t *	n

  PREINIT:
    int len;
    
  CODE:
    len = mpz_sizeinbase(*n, 10);
    {
      char *buf;
      buf = malloc(len + 2);
      mpz_get_str(buf, 10, *n);
      RETVAL = newSVpv(buf, strlen(buf));
      free(buf);
    }
  OUTPUT:
    RETVAL


SV *
get_str_gmp(n, b)
       mpz_t * n
        int b

  PREINIT:
    int len;

  CODE:
    len = mpz_sizeinbase(*n, b);
    {
        char *buf;
        buf = malloc(len + 2);
        mpz_get_str(buf, b, *n);
        RETVAL = newSVpv(buf, strlen(buf));
        free(buf);
    }
  OUTPUT:
    RETVAL

int
sizeinbase_gmp(n, b)
       mpz_t * n
       int b

  CODE:
    RETVAL = mpz_sizeinbase(*n, b);
  OUTPUT:
    RETVAL

unsigned long
uintify_gmp(n)
       mpz_t * n

  CODE:
    RETVAL = mpz_get_ui(*n);
  OUTPUT:
    RETVAL

void
add_ui_gmp(n, v)
       mpz_t * n
       unsigned long v

  CODE:
    mpz_add_ui(*n, *n, v);


long 
intify_gmp(n)
	mpz_t *	n

  CODE:
    RETVAL = mpz_get_si(*n);
  OUTPUT:
    RETVAL

mpz_t *
mul_2exp_gmp(n, e)
       mpz_t * n
       unsigned long e

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_mul_2exp(*RETVAL, *n, e);
  OUTPUT:
    RETVAL

mpz_t *
div_2exp_gmp(n, e)
       mpz_t * n
       unsigned long e

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_div_2exp(*RETVAL, *n, e);
  OUTPUT:
    RETVAL


mpz_t *
powm_gmp(n, exp, mod)
       mpz_t * n
       mpz_t * exp
       mpz_t * mod

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_powm(*RETVAL, *n, *exp, *mod);
  OUTPUT:
    RETVAL


mpz_t *
mmod_gmp(a, b)
       mpz_t * a
       mpz_t * b

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_mmod(*RETVAL, *a, *b);
  OUTPUT:
    RETVAL


mpz_t *
mod_2exp_gmp(in, cnt)
       mpz_t * in
       unsigned long cnt

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_mod_2exp(*RETVAL, *in, cnt);
  OUTPUT:
    RETVAL


mpz_t *
add_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_add(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL


mpz_t *
sub_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_sub(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL


mpz_t *
mul_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_mul(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL


mpz_t *
div_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_div(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL


void
bdiv_two(m,n)
	mpz_t *		m
	mpz_t *		n

  PREINIT:
    mpz_t * quo;
    mpz_t * rem;
  PPCODE:
    quo = malloc (sizeof(mpz_t));
    rem = malloc (sizeof(mpz_t));
    mpz_init(*quo);
    mpz_init(*rem);
    mpz_tdiv_qr(*quo, *rem, *m, *n);
  EXTEND(SP, 2);
  PUSHs(sv_setref_pv(sv_newmortal(), "Math::GMP", (void*)quo));
  PUSHs(sv_setref_pv(sv_newmortal(), "Math::GMP", (void*)rem));



mpz_t *
mod_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_mod(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL


int
cmp_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = mpz_cmp(*m, *n);
  OUTPUT:
    RETVAL

int
gmp_legendre(m, n)
        mpz_t *         m
        mpz_t *         n

  CODE:
    RETVAL = mpz_legendre(*m, *n);
  OUTPUT:
    RETVAL

int
gmp_jacobi(m, n)
        mpz_t *         m
        mpz_t *         n

  CODE:
    RETVAL = mpz_jacobi(*m, *n);
  OUTPUT:
    RETVAL

int
gmp_probab_prime(m, reps)
    mpz_t * m
    int reps

    CODE:
        RETVAL = mpz_probab_prime_p(*m, reps);
    OUTPUT:
        RETVAL

mpz_t *
pow_two(m,n)
	mpz_t *		m
	long		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
/*    fprintf(stderr, "n is %ld\n", n);*/
    mpz_pow_ui(*RETVAL, *m, n);
  OUTPUT:
    RETVAL


mpz_t *
gcd_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_gcd(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL


mpz_t *
gmp_fib(n)
	long		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_fib_ui(*RETVAL, n);
  OUTPUT:
    RETVAL


mpz_t *
and_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_and(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL

mpz_t *
xor_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_xor(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL


mpz_t *
or_two(m,n)
	mpz_t *		m
	mpz_t *		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_ior(*RETVAL, *m, *n);
  OUTPUT:
    RETVAL


mpz_t *
gmp_fac(n)
	long		n

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_fac_ui(*RETVAL, n);
  OUTPUT:
    RETVAL


mpz_t *
gmp_copy(m)
	mpz_t *		m

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init_set(*RETVAL, *m);
  OUTPUT:
    RETVAL

int
gmp_tstbit(m,n)
	mpz_t *		m
	long		n

  CODE:
    RETVAL = mpz_tstbit(*m,n);
  OUTPUT:
    RETVAL

mpz_t *
gmp_sqrt(m)
	mpz_t *		m

  CODE:
    RETVAL = malloc (sizeof(mpz_t));
    mpz_init(*RETVAL);
    mpz_sqrt(*RETVAL, *m);
  OUTPUT:
    RETVAL


