#!/usr/bin/perl -w

# basic testing of SDL::Cursor

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Cursor' ); 
  }
  
can_ok ('SDL::Cursor', qw/
	new warp use get show
	/);

# does not work, segmentation fault due to missing options that are required
#my $cursor = SDL::Cursor->new();
#
#is (ref($cursor), 'SDL::Cursor', 'new was ok');

