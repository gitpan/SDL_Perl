#	App.pm
#
#	The application object, sort of like a surface
#
#	Copyright (C) 2000,2002 David J. Goehrig

package SDL::App;
use strict;
use vars qw(@ISA);

use SDL;

use SDL::Surface;
@ISA = qw(SDL::Surface Exporter);


BEGIN {
	use Exporter();
	use vars qw(@EXPORT);
	@EXPORT = qw(&SDL_SWSURFACE &SDL_HWSURFACE &SDL_ANYFORMAT 
		     &SDL_HWPALETTE &SDL_DOUBLEBUF &SDL_FULLSCREEN
		     &SDL_TEXTWIDTH 
		     &SDL_RESIZABLE	
		     &SDL_HWACCEL	
		     &SDL_SRCCOLORKEY	
		     &SDL_RLEACCELOK	
		     &SDL_RLEACCEL	
		     &SDL_SRCALPHA	
		     &SDL_ASYNCBLIT
		    );
}

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my %options = @_;

	SDL::Init(SDL::INIT_EVERYTHING());

	my $t = $options{-title} 	|| "";
	my $it = $options{-icon_title} 	|| $t;
	my $ic = $options{-icon} 	|| "";
	my $w = $options{-width} 	|| 0;
	my $h = $options{-height} 	|| 0;
	my $d = $options{-depth} 	|| 0;
	my $f = $options{-flags} 	|| SDL::ANYFORMAT();

	my $self = new SDL::Surface ();
	SDL::FreeSurface ($self->{-surface});

	($self->{-surface} = SDL::SetVideoMode($w,$h,$d,$f)) 
		or die SDL::GetError();
	
	if ($ic and -e $ic) {
	   my $icon = new SDL::Surface -name => $ic;
	   SDL::WMSetIcon($icon->{-surface});	   
	}

	SDL::WMSetCaption($t,$it);
	
	bless $self,$class;
	return $self;
}	

sub title ($;$) {
	my $self = shift;
	my ($title,$icon);
	if (@_) { $title = shift; 
		$icon = shift || $title;
		SDL::WMSetCaption($title,$icon);
	}
	return SDL::WMGetCaption();
}

sub delay ($$) {
	my $self = shift;
	my $delay = shift;
	SDL::Delay($delay);
}

sub ticks {
	return SDL::GetTicks();
}

sub error {
	return SDL::GetError();
}

sub warp ($$$) {
	my $self = shift;
	my $x = shift;
	my $y = shift;
	SDL::WarpMouse($x,$y);
}
sub SDL_SWSURFACE {
	return SDL::SWSURFACE;
}

sub SDL_HWSURFACE {
	return SDL::HWSURFACE;
}

sub SDL_ANYFORMAT  {
	return SDL::ANYFORMAT;
}

sub SDL_HWPALETTE {
	return SDL::HWPALETTE;
}

sub SDL_DOUBLEBUF {
	return SDL::DOUBLEBUF;
}

sub SDL_FULLSCREEN {
	return SDL::FULLSCREEN;
}

sub SDL_TEXTWIDTH {
	return SDL::TextWidth(join('',@_));
}

sub SDL_RESIZABLE {
	return SDL::RESIZABLE;
}

sub SDL_HWACCEL {	
	return SDL::HWACCEL;
}

sub SDL_SRCCOLORKEY {
	return SDL::SRCCOLORKEY;
}

sub SDL_RLEACCELOK {
	return SDL::RLEACCELOK;
}

sub SDL_RLEACCEL {
	return SDL::RLEACCEL;
}

sub SDL_SRCALPHA {
	return SDL::SRCALPHA;
}

sub SDL_ASYNCBLIT {
	return SDL::ASYNCBLIT;
}

1;

__END__;

=head1 NAME

SDL::App - a SDL perl extension

=head1 SYNOPSIS

  $app = new SDL::App ( -title => 'FunkMeister 2000', 
			-icon_title => 'FM2000',
			-icon => 'funkmeister.png', 
			-width => 400, 
			-height => 400 );

=head1 DESCRIPTION


This Object is a composite made up of a few surfaces,
and strings.  This object does the setup for the SDL
library, and greates the base application window.  

The options that the constructor takes are:
	
-title =>	the title bar of the window
-icon_title =>	the title bar of the icon
-icon =>	the icon image file
-flags =>	the SDL_* surface flags for the	default window
-width =>	of the app window
-height =>	of the app window
-depth =>	the bit depth of the window

=head2 Additional Methods

	In addition to initilizing the SDL library, the app class
provides access to a couple miscellaneous functions that all programs
may need:

	$app->delay(milliseconds);

Delay will cause a delay of roughly the specified milliseconds. Since
this only runs in multi-tasking environments, the exact number is not
assured.

	$app->ticks();

Ticks returns the number of clock ticks since the program was started.

	$app->error();

Error returns any pending SDL related error messages.  It returns an
empty string if no errors are pending, making it print friendly.

	$app->warp(x,y);

Will move the cursor to the location x,y.

=head1 AUTHOR

David J. Goehrig

=head1 SEE ALSO

perl(1) SDL::Surface(3) SDL::Mixer(3) SDL::Event(3) SDL::Cdrom(3).

=cut	

