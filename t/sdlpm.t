#!/usr/bin/perl -w

use Test::More tests => 9;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL' ); 
  }
  
can_ok ('SDL', qw/in verify/);

is (SDL::in('foo','bar'), 0, "foo isn't in ('bar')");
is (SDL::in('foo','foo'), 1, "foo is in ('foo')");
is (SDL::in('foo','foo','bar'), 1, "foo is in ('foo','bar')");
is (SDL::in('foo','foo','bar','foo'), 1, "foo is once in ('foo','bar','foo')");
is (SDL::in('foo','fab','bar'), 0, "foo isn't in ('fab','bar')");
is (SDL::in('foo','fab',undef,'bar'), 0, "foo isn't in ('fab',undef,'bar')");
is (SDL::in('foo','fab',undef,'foo'), 1, "foo is in ('fab',undef,'foo')");

