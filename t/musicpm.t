#!/usr/bin/perl -w

# basic testing of SDL::Music

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Music' ); 
  }
  
can_ok ('SDL::Music', qw/
	new
	/);

# does not work
#my $music = SDL::Music->new();
