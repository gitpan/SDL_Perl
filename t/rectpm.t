#!/usr/bin/perl -w

# basic testing of SDL::Rect

use Test::More tests => 15;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Rect' ); 
  }
  
can_ok ('SDL::Rect', qw/
	new
	x y width height
	/);

my $rect = SDL::Rect->new();

# creating with defaults
is (ref($rect),'SDL::Rect','new went ok');
is ($rect->x(), 0, 'x is 0');
is ($rect->y(), 0, 'y is 0');
is ($rect->width(), 0, 'w is 0');
is ($rect->height(), 0, 'h is 0');

# set and get at the same time
is ($rect->x(12), 12, 'x is now 12');
is ($rect->y(123), 123, 'y is now 12');
is ($rect->width(45), 45, 'w is now 45');
is ($rect->height(67), 67, 'h is now 67');

# get alone
is ($rect->x(), 12, 'x is 12');
is ($rect->y(), 123, 'y is 12');
is ($rect->width(), 45, 'w is 45');
is ($rect->height(), 67, 'h is 67');

