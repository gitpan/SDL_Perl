# Cursor.pm
#
#	Copyright (C) 2000,2002 David J. Goehrig
#

package SDL::Cursor;
use strict;
use SDL;

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self = {};
	my %options = @_;
	$self->{-data} = $options{-data};
	$self->{-mask} = $options{-mask};
	$self->{-x} = $options{-x};
	$self->{-y} = $options{-y};
	$self->{-cursor} = SDL::NewCursor($self->{-data},$self->{-mask},
				$self->{-x},$self->{-y});
	bless $self, $class;
	return $self;
}

sub DESTROY ($) {
	my $self = shift;
	SDL::FreeCursor($self->{-cursor});
}

sub warp ($$$) {
	my ($self,$x,$y) = @_;
	SDL::WarpMouse($x,$y);
}

sub use ($) {
	my $self = shift;
	SDL::SetCursor($self->{-cursor});
}

sub get () {
	return SDL::GetCursor();
}

sub show ($;$) {
	my ($self,$toggle) = @_;
	return SDL::ShowCursor($toggle);
}

1;

__END__;

=head1 NAME

SDL::Cursor - a SDL perl extension

=head1 SYNOPSIS

 $cursor = new SDL::Cursor 	-data => new SDL::Surface "cursor.png", 
				-mask => new SDL::Surface "mask.png",
				-x => 0, -y => 0;


=head1 DESCRIPTION


=head1 AUTHOR

David J. Goehrig

=head1 SEE ALSO

perl(1) SDL::Surface(3).

=cut	
