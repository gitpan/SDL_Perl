#	Mixer.pm
#
#	a SDL module for manipulating the SDL_mixer lib.
#
#	Copyright (C) 2000,2002 David J. Goehrig

package SDL::Mixer;
use strict;
use SDL;
require SDL::Music;
require SDL::Sound;

BEGIN {
	use Exporter();
	use vars qw(@EXPORT @ISA);
	@ISA = qw(Exporter);
	@EXPORT = qw(&MIX_MAX_VOLUME &MIX_DEFAULT_FREQUENCY &MIX_DEFAULT_FORMAT
			&MIX_DEFAULT_CHANNELS &MIX_NO_FADING &MIX_FADING_OUT
			&MIX_FADING_IN &AUDIO_U8 &AUDIO_S8 &AUDIO_U16 
			&AUDIO_S16 &AUDIO_U16MSB &AUDIO_S16MSB );
}

sub MIX_MAX_VOLUME { return SDL::MIX_MAX_VOLUME(); }
sub MIX_DEFAULT_FREQUENCY { return SDL::MIX_DEFAULT_FREQUENCY(); }
sub MIX_DEFAULT_FORMAT { return SDL::MIX_DEFAULT_FORMAT(); }
sub MIX_DEFAULT_CHANNELS { return SDL::MIX_DEFAULT_CHANNELS(); }
sub MIX_NO_FADING { return SDL::MIX_NO_FADING(); }
sub MIX_FADING_OUT { return SDL::MIX_FADING_OUT(); }
sub MIX_FADING_IN { return SDL::MIX_FADING_IN(); }
sub AUDIO_U8 { return SDL::AUDIO_U8(); }
sub AUDIO_S8 { return SDL::AUDIO_S8(); }
sub AUDIO_U16 { return SDL::AUDIO_U16(); }
sub AUDIO_S16 { return SDL::AUDIO_S16(); }
sub AUDIO_U16MSB { return SDL::AUDIO_U16MSB(); }
sub AUDIO_S16MSB { return SDL::AUDIO_S16MSB(); }

$SDL::Mixer::initialized = 0;

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self = {};
	my %options = @_;
	my $frequency = $options{-frequency} || $options{-rate} || MIX_DEFAULT_FREQUENCY();
	my $format = $options{-format} || MIX_DEFAULT_FORMAT();
	my $channels = $options{-channels} || MIX_DEFAULT_CHANNELS();
	my $size = $options{-size} || 4096;
	unless ( $SDL::Mixer::initialized ) {
		SDL::MixOpenAudio($frequency,$format,$channels,$size ) && 
			die SDL::GetError(); 
		$SDL::Mixer::initialized = 1;
	} else {
		++$SDL::Mixer::initialized;
	}
	bless $self,$class;
	return $self;
}	

sub DESTROY {
	my $self = shift;
	--$SDL::Mixer::initialized;
	unless ($SDL::Mixer::initialized) {
		SDL::MixCloseAudio();
	}
}


sub query_spec () {
	my ($status,$freq,$format,$channels) = SDL::MixQuerySpec();
	my %hash = ( -status => $status, -frequency => $freq, 
			-format => $format, -channels => $channels );
	return \%hash;
}

sub reserve_channels ($$) {
	my ($self,$channels) = @_;
	return SDL::MixReserveChannels($channels);
}

sub allocate_channels ($$) {
	my ($self,$channels) = @_;
	return SDL::MixAllocateChannels($channels);
}

sub group_channel ($$$) {
	my ($self,$channel,$group) = @_;
	return SDL::MixGroupChannel($channel, $group);
}

sub group_channels ($$$$) {
	my ($self,$from,$to,$group) = @_;
	return SDL::MixGroupChannels($from,$to,$group);
}

sub group_available ($$) {
	my ($self,$group) = @_;	
	return SDL::MixGroupAvailable($group);
}

sub group_count ($$) {
	my ($self,$group) = @_;	
	return SDL::MixGroupCount($group);
}	

sub group_oldest ($$) {
	my ($self,$group) = @_;	
	return SDL::MixGroupOldest($group);
}	

sub group_newer ($$) {
	my ($self,$group) = @_;	
	return SDL::MixGroupNewer($group);
}	

sub play_channel ($$$$;$) {
	my ($self,$channel,$chunk,$loops,$ticks) = @_;
	$ticks ||= -1; 
	return SDL::MixPlayChannelTimed($channel,$chunk->{-data},$loops,$ticks);
}

sub play_music ($$$) {
	my ($self,$music,$loops) = @_;
	return SDL::MixPlayMusic($music->{-data},$loops);
}

sub fade_in_channel ($$$$$;$) {
	my ($self,$channel,$chunk,$loops,$ms,$ticks) = @_;
	$ticks ||= -1;
	return SDL::MixFadeInChannelTimed($channel,$chunk->{-data},$loops,$ms,$ticks);
}

sub fade_in_music ($$$$) {
	my ($self,$music,$loops,$ms,$ms) = @_;
	return SDL::MixFadeInMusic($music->{-data},$loops,$ms);
}

sub channel_volume ($$$) {
	my ($self,$channel,$volume) = @_;
	return SDL::MixVolume($channel,$volume);
}

sub music_volume ($$) {
	my ($self,$volume) = @_;
	return SDL::MixVolumeMusic($volume);
}

sub halt_channel ($$) {
	my ($self,$channel) = @_;
	return SDL::MixHaltChannel($channel);
}

sub halt_group ($$) {
	my ($self,$group) = @_;
	return SDL::MixHaltGroup($group);
}

sub halt_music (){
	return SDL::MixHaltMusic();
}

sub channel_expire ($$$) {
	my ($self,$channel,$ticks) = @_;
	return SDL::MixExpireChannel($channel,$ticks);
}

sub fade_out_channel ($$$) {
	my ($self,$channel,$ms) = @_;
	return SDL::MixFadeOutChannel($channel,$ms);
}

sub fade_out_group ($$$) {
	my ($self,$group,$ms) = @_;
	return SDL::MixFadeOutGroup($group,$ms);
}

sub fade_out_music ($$) {
	my ($self,$ms) = @_;
	return SDL::MixFadeOutMusic($ms);
}

sub fading_music () {
	return SDL::MixFadingMusic();
}

sub fading_channel ($$) {
	my ($self,$channel) = @_;
	return SDL::MixFadingChannel($channel);
}
	
sub pause ($$) {
	my ($self,$channel) = @_;
	SDL::MixPause($channel);
}

sub resume ($$) {
	my ($self,$channel) = @_;
	SDL::MixResume($channel);
}

sub paused ($$) {
	my ($self,$channel) = @_;
	return SDL::MixPaused($channel);
}

sub pause_music () {
	SDL::MixPauseMusic();
}

sub resume_music () {
	SDL::MixResumeMusic();
}

sub rewind_music (){
	SDL::MixRewindMusic();
}

sub music_paused (){
	return SDL::MixPausedMusic();
}

sub playing ($$) {
	my ($self,$channel) = @_;
	return SDL::MixPlaying($channel);
}

sub playing_music () {
	return SDL::MixPlayingMusic();
}

1;

__END__;

=head1 NAME

SDL::Mixer - a SDL perl extension

=head1 SYNOPSIS

  $mixer = new SDL::Mixer 	-frequency => MIX_DEFAULT_FREQUENCY,
				-format => MIX_DEFAULT_FORMAT,
				-channels => MIX_DEFAULT_CHANNELS,
				-size => 4096;

=head1 DESCRIPTION

to be rewritten

=head1 AUTHOR 

David J. Goehrig

=head1 SEE ALSO

perl(1) SDL::Music(3) SDL::Sound(3)

=cut


