#!perl

use strict;
use warnings;
use ExtUtils::MakeMaker;

my $output = WriteMakefile
	(
	 'NAME'	        => 'Math::GMP',
	 'VERSION_FROM' => 'lib/Math/GMP.pm',
	 'LIBS'	        => ['-lgmp'],
	 'NO_META'      => 1,
	 );

if (!exists $output->{EXTRALIBS} or $output->{EXTRALIBS} !~ /gmp/) {

	my $makefile = exists $output->{MAKEFILE}
		? "\nRemoving ($output->{MAKEFILE})\n" : '';

	warn qq{
==========================================================

WARNING! No GMP libraries were detected!

Please see the INSTALL file.

===========================================================

};

	## Do not let make proceed
	if ($makefile) {
		print $makefile;
		unlink $output->{MAKEFILE};
	}

	unlink $output->{MAKEFILE} if $makefile;

	exit 1;
}

exit 0;

# end of Makefile.PL
