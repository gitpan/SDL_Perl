#!/usr/bin/perl -w

# basic testing of SDL::Sound

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Sound' ); 
  }
  
can_ok ('SDL::Sound', qw/
	new volume
	/);

# does not work
#my $sound = SDL::Sound->new();
