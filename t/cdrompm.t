#!/usr/bin/perl -w

# basic testing of SDL::Cdrom

use Test::More tests => 3;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Cdrom' ); 
  }
  
can_ok ('SDL::Cdrom', qw/
	new
	name status play pause resume stop
	eject id num_tracks track
	current current_frame
	/);

# These are exported by default, so main:: should know about them
can_ok ('main', qw/
	CD_NUM_DRIVES
       /);
