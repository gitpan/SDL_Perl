#!/usr/bin/perl -w

# basic testing of SDL::Surface

use Test::More tests => 3;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Surface' ); 
  }
  
can_ok ('SDL::Surface', qw/
	new
	flags
	palette
	bpp
	bytes_per_pixel
	Rshift
	Gshift
	Bshift
	Ashift
	Rmask
	Bmask
	Gmask
	Amask
	color_key
	alpha
	width
	height
	pitch
	pixels
	pixel
	fill
	lockp
	lock
	unlock
	update
	flip
	blit
	set_colors
	set_color_key
	set_alpha
	display_format
	rgb
	rgba
	print
	save_bmp
	video_info
	/);

my $surface = SDL::Surface->new( -name => '');

is (ref($surface),'SDL::Surface','new went ok');

