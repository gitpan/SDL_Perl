#!/usr/bin/env perl

open XS, "< opengl_words.txt";
open CPP, "| cpp -I. - > OpenGL.cx";

print CPP <<HEADER;
#include <GL/gl.h>
#include <GL/glu.h>

--cut--
HEADER

while (<XS>) {
	chomp();
	print CPP "_$_ $_\n";
	$words{$_} = 0;
}

close XS;
close CPP;

my $text;
open FP, "< OpenGL.cx" 
	or die "Couldn't open OpenGL.cx\n";
{
	local $/ = undef;
	$text = <FP>;
}

my ($junk,$goodstuff) = split "--cut--", $text;

#$goodstuff =~ s/_(GL[U]?_[A-Z0-9_]+)\s+([0-9xa-fA-F]+)/\t$1 => $2,/g;
	
#for (split "\n",$goodstuff) {
#	if (/(GL[U]?_[A-Z0-9_]+) =>/ ) {
#		push @words, $1;
#	}
#}

my %constant;

for (split "\n",$goodstuff) {
	if (/_(GL[U]?_[A-Z0-9_]+)\s+([0-9xa-fA-F]+)/) {
		$constant{$1}=$2;
		push @words,$1;
	}
}

for ( @words ) {
	$words{$_} = 1;
}

for ( keys %words ) {
	print STDERR "Failed to find word $_\n" unless ($words{$_});
}

open OGL, "> ../lib/SDL/OpenGL/Constants.pm" or die "Could not write to file $!\n";

$words = join(" ",@words);

print OGL <<HERE;
# SDL::OpenGL::Constants
#
# This is an autogenerate file, don't bother editing
#
# Copyright (C) 2003 David J. Goehrig <dave\@sdlperl.org>

package SDL::OpenGL::Constants;

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

print OGL "\t".join("\n\t",sort keys %constant)."\n";

print OGL <<HERE;
);

__DATA__
HERE

foreach my $k (sort keys %constant) {
	print OGL "sub $k {$constant{$k}}\n";
}

close OGL;

unlink("OpenGL.cx");
