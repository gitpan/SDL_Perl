#!/usr/bin/perl -w

# basic testing of SDL::Tool::Graphic

use Test::More tests => 3;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Tool::Graphic' ); 
  }
  
can_ok ('SDL::Tool::Graphic', qw/
	new zoom rotoZoom
	/);

my $gtool = SDL::Tool::Graphic->new();
is (ref($gtool), 'SDL::Tool::Graphic', 'new was ok');

