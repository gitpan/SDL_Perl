#!/usr/bin/perl -w

# basic testing of SDL::Mixer

use Test::More tests => 3;
use strict;
use vars qw/@INC/;

BEGIN
  {
  unshift @INC, ('../lib', '..');	# unfortunately, SDL.pm is not in lib/
  chdir 't' if -d 't';
  use_ok( 'SDL::Mixer' ); 
  }
  
can_ok ('SDL::Mixer', qw/
	new
	query_spec
	reserve_channels
	allocate_channels
	group_channel
	group_channels
	group_available
	group_count
	group_oldest
	group_newer
	play_channel
	play_music
	fade_in_channel
	fade_in_music
	channel_volume
	music_volume
	halt_channel
	halt_group
	halt_music
	channel_expire
	fade_out_channel
	fade_out_group
	fade_out_music
	fading_music
	fading_channel
	pause
	resume
	paused
	pause_music
	resume_music
	rewind_music
	music_paused
	playing
	playing_music
	/);

# these are exported by default, so main:: should know them:

my $mixer = SDL::Mixer->new();
is (ref($mixer), 'SDL::Mixer', 'new was ok');

