#!/usr/bin/perl -w

# basic testing of SDL::TTFont

use Test::More tests => 2;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::TTFont' ); 
  }
  
can_ok ('SDL::TTFont', qw/
	new print width height
	ascent descent normal bold italic underline
	text_shaded text_solid text_blended 
	utf8_shaded utf8_solid utf8_blended 
	unicode_shaded unicode_solid unicode_blended
	/);
