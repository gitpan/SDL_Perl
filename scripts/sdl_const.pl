#!/usr/bin/env perl
#

open XS, "< sdl_words.txt" or die "could not open sdl_words.txt\n";

while (<XS>) {
	chomp;
	$words{$_} = 0;
}

close XS;

#
# ENUMS AREN'T CPPed we got to do this the hard way
#
open FP, "> sdl_const.c" or die "Could not write to sdl_const.c\n";

print FP <<HERE;
#include <SDL.h>
#include <SDL_image.h>
#include <SDL_mixer.h>
#include <SDL_ttf.h>
#include <SDL_net.h>
#include <smpeg/smpeg.h>
#define TEXT_SOLID	1
#define TEXT_SHADED	2
#define TEXT_BLENDED	4
#define UTF8_SOLID	8
#define UTF8_SHADED	16	
#define UTF8_BLENDED	32
#define UNICODE_SOLID	64
#define UNICODE_SHADED	128
#define UNICODE_BLENDED	256

int
main ( int argc, char **argv ) {

HERE

for ( keys %words ) { 
	print FP <<THERE;
fprintf(stdout,"$_=\%i\\n",$_);
THERE
}

print FP <<HERE;
}
HERE

system("gcc `sdl-config --cflags --libs` -o sdl_const sdl_const.c");

my $enums;
open ENUMS, "./sdl_const |";
{
	local $/ = undef;
	$enums = <ENUMS>;
}
close ENUMS;

$goodstuff .= "\n$enums";

my %constant;

for ( split "\n", $goodstuff ) {
	if (/^([A-Za-z0-9_]+)=(.*)$/) {
		$words{$1} = 1;
		$constant{$1}=$2;
	}
}

for (keys %words) {
	print STDERR "Failed to find $_\n" unless $words{$_};	
}

open CONST, "> ../lib/SDL/Constants.pm";

print CONST <<HERE;
# SDL::Constants
#
# This is an automatically generated file, don't bother editing
#
# Copyright (C) 2003 David J. Goehrig <dave\@sdlperl.org>
#

package SDL::Constants;

require Exporter;

use SelfLoader;
#\$SelfLoader::DEBUG=1;

use vars qw(
	\@EXPORT
	\@ISA
);

\@ISA=qw(Exporter);
\@EXPORT=qw(
HERE

print CONST "\t".join("\n\t",sort keys %constant)."\n";

print CONST <<HERE;
);

__DATA__
HERE

foreach my $k (sort keys %constant) {
	print CONST "sub $k {$constant{$k}}\n";
}

close CONST;

unlink("sdl_const.c");
unlink("sdl_const");
