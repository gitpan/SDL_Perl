#!/usr/bin/perl -w

# basic testing of SDL::App

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::App' ); 
  }
  
can_ok ('SDL::App', qw/
	new title delay ticks error warp fullscreen iconify
	grab_input loop attribute/);

