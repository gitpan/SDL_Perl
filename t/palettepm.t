#!/usr/bin/perl -w

# basic testing of SDL::Palette

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Palette' ); 
  }
  
can_ok ('SDL::Palette', qw/
	new
	size red green blue color
	/);

