#!/usr/bin/perl -w

# basic testing of SDL::Font

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Font' ); 
  }
  
can_ok ('SDL::Font', qw/
	new use
	/);

# does not work
#my $font = SDL::Font->new();
#is (ref($font), 'SDL::Font', 'new was ok');

