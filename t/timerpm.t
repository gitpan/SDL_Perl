#!/usr/bin/perl -w

# basic testing of SDL::Timer

use Test::More tests => 4;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Timer' ); 
  }
  
can_ok ('SDL::Timer', qw/
	new run stop
	/);

use SDL;

my $fired = 0;

SDL::Init(SDL_INIT_TIMER);

my $timer = SDL::Timer->new( sub { $fired++ }, -delay => 30, -times => 1);

is (ref($timer), 'SDL::Timer', 'new went ok');

SDL::Delay(100);
is ($fired, 1,'timer fired once');
