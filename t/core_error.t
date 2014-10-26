#!/usr/bin/perl
use strict;
use warnings;
use SDL;
use Test::More tests => 5;

use lib 't/lib';
use SDL::TestTool;

SKIP:
{
	skip "Video fail", 1 unless SDL::TestTool->init(SDL_INIT_VIDEO);
is( SDL::init(SDL_INIT_VIDEO), 0, '[init] returns 0 on success' );

}
SDL::set_error('Hello');
is( SDL::get_error, 'Hello', '[get_error] returns Hello' );

SDL::set_error('Hello %s!', 'SDL');
is( SDL::get_error, 'Hello SDL!', '[get_error] returns Hello SDL!' );

SDL::set_error('Hello %s! Three is %d.', 'SDL', 3);
is( SDL::get_error, 'Hello SDL! Three is 3.', '[get_error] returns Hello SDL! Three is 3.' );

SDL::clear_error();
is( SDL::get_error, '', '[get_error] returns no error' );
