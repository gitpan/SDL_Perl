#!/usr/bin/perl -w

# basic testing of SDL::Event

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Event' ); 
  }
  
can_ok ('SDL::Event', qw/
	new 
	type pump poll wait set set_unicode set_key_repeat
	active_gain active_state key_state key_sym key_name key_mod
	key_unicode key_scancode motion_state
	motion_x motion_y motion_xrel motion_yrel
	button button_state button_x button_y
	/);



