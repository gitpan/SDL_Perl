#	Cdrom.pm
#
#	a SDL cdrom manipluation module
#
#	Copyright (C) 2000,2002 David J. Goehrig
#

package SDL::Cdrom;
use strict;
use SDL;

BEGIN {
	use Exporter();
	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);
	@EXPORT = qw/ &CD_NUM_DRIVES /;
}

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self = {};
	$self->{-number} = shift;
	$self->{-cdrom} = SDL::CDOpen($self->{-number});
	die SDL::GetError() if ( SDL::CD_ERROR() eq SDL::CDStatus($self->{-cdrom}));
	bless $self,$class;
	return $self;
}

sub DESTROY {
	my $self = shift;
	SDL::CDClose($self->{-cdrom});
}

sub CD_NUM_DRIVES {
	return SDL::CDNumDrives();
}

sub name ($) {
	my $self = shift;
	return SDL::CDName($self->{-cdrom});
}

sub status ($) {
	my $self = shift;
	return SDL::sdlpl::sdl_cd_status($self->{-cdrom});
}

sub play ($$$;$$) {
	my ($self,$start,$length,$fs,$fl) = @_;
	return SDL::CDPlayTracks($self->{-cdrom},$start,$length,$fs,$fl);
}

sub pause ($) {
	my $self = shift;
	return SDL::CDPause($self->{-cdrom});
}

sub resume ($) {
	my $self = shift;
	return SDL::CDResume($self->{-cdrom});
}

sub stop ($) {
	my $self = shift;
	return SDL::CDStop($self->{-cdrom});
}

sub eject ($) {
	my $self = shift;
	return SDL::CDEject($self->{-cdrom});
}

sub id ($) {
	my $self = shift;
	return SDL::CDId($self->{-cdrom});
}

sub num_tracks ($) {
	my $self = shift;
	return SDL::CDNumTracks($self->{-cdrom});
}

my $buildtrack = sub {
	my $ptr = shift;
	my %track = ();
	$track{-id} = SDL::CDTrackId($ptr);
	$track{-type} = SDL::CDTrackType($ptr);
	$track{-length} = SDL::CDTrackLength($ptr);
	$track{-offset} = SDL::CDTrackOffset($ptr);
	return \%track;
};

sub track {
	my $self = shift;
	my $number = shift;
	return &$buildtrack(SDL::CDTrack($self->{-cdrom},$number));
}

sub current {
	my $self = shift;
	return $self->track(SDL::CDCurTrack($self->{-cdrom}));
}

sub current_frame {
	my $self = shift;
	return SDL::CDCurFrame($self->{-cdrom});
}

1;

__END__;

=head1 NAME

SDL::Cdrom - a SDL perl extension

=head1 SYNOPSIS

  $cdrom = new SDL::Cdrom 0;

=head1 DESCRIPTION

to be rewritten
	
=head1 AUTHOR

David J. Goehrig

=head1 SEE ALSO

perl(1) SDL::Mixer(3) SDL::App(3).

=cut
