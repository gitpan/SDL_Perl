#!/usr/bin/perl -w

# basic testing of SDL::Tool::Font

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Tool::Font' ); 
  }
  
can_ok ('SDL::Tool::Font', qw/
	new print
	/);

# does not work
#my $fonttool = SDL::Tool::Font->new();
#is (ref($fonttool), 'SDL::Tool::Font', 'new was ok');

