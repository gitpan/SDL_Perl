#!/usr/bin/env perl

#
# Supported OSes
#

%OS = (
	linux 	=> "Makefile.linux",
	win 	=> "Makefile.win32",
	freebsd => "Makefile.freebsd",
);

#
# Load applicable makefile
#

for (keys %OS ) {
	require "$OS{$_}" && last if ($^O =~ /$_/);
}
