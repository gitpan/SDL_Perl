# 
#	Surface.pm
#
#	A package for manipulating SDL_Surface *
#
#	David J. Goehrig Copyright (C) 2000, 2002

package SDL::Surface;
use strict;
use SDL;
require SDL::Rect;
require SDL::Palette;

require Exporter;

sub new {
	my $proto = shift;	
	my $class = ref($proto) || $proto;
	my $self = {};
	my %options = @_;

	if ( exists($options{-name}) && exists $SDL::{IMGLoad} ) {		
	   $self->{-surface} = SDL::IMGLoad($options{-name});	
	} else {
		my $f = $options{-flags}  || SDL::ANYFORMAT();
		my $w = $options{-width} 	|| 0;
		my $h = $options{-height} 	|| 0;	
		my $d = $options{-depth} 	|| 0;
		my $p = $options{-pitch} 	|| 0;                          
		my $r = $options{-Rmask} 	
			||  ( SDL::BigEndian() ? 0xff000000 : 0x000000ff );
		my $g = $options{-Gmask} 
			||  ( SDL::BigEndian() ? 0x00ff0000 : 0x0000ff00 );
		my $b = $options{-Bmask} 
			||  ( SDL::BigEndian() ? 0x0000ff00 : 0x00ff0000 );
		my $a = $options{-Amask} 
			||  ( SDL::BigEndian() ? 0x000000ff : 0xff000000 );

		if ( $options{-from} ) { 

			$self->{-surface} = SDL::CreateRGBSurfaceFrom(
				$options{-from},$w,$h,$d,$p,$r,$g,$b,$a);
		} else {
			$self->{-surface} = SDL::CreateRGBSurface(
				$f,$w,$h,$d,$r,$g,$b,$a);
		}
	}
	bless $self,$class;
	return $self;
}

sub DESTROY {		
	my $self = shift;	
	SDL::FreeSurface($self->{-surface});	
}

sub flags {
	my $self = shift;
	return SDL::SurfaceFlags($self->{-surface});
}

sub palette {
	my $self = shift;
	return SDL::SurfacePalette($self->{-surface});
}

sub bpp {
	my $self = shift;
	return SDL::SurfaceBitsPerPixel($self->{-surface});
}

sub bytes_per_pixel {
	my $self = shift;
	return SDL::SurfaceBytesPerPixel($self->{-surface});
}

sub Rshift {
	my $self = shift;
	return SDL::SurfaceRshift($self->{-surface});
}

sub Gshift {
	my $self = shift;
	return SDL::SurfaceGshift($self->{-surface});
}

sub Bshift {
	my $self = shift;
	return SDL::SurfaceBshift($self->{-surface});
}

sub Ashift {
	my $self = shift;
	return SDL::SurfaceAshift($self->{-surface});
}

sub Rmask {
	my $self = shift;
	return SDL::SurfaceRmask($self->{-surface});
}

sub Gmask {
	my $self = shift;
	return SDL::SurfaceGmask($self->{-surface});
}

sub Bmask {
	my $self = shift;
	return SDL::SurfaceBmask($self->{-surface});
}

sub Amask {
	my $self = shift;
	return SDL::SurfaceAmask($self->{-surface});
}

sub color_key {
	my $self = shift;
	return SDL::SurfaceColorKey($self->{-surface});
}

sub alpha {
	my $self = shift;
	return SDL::SurfaceAlpha($self->{-surface});
}

sub width {
	my $self = shift;
	return SDL::SurfaceW($self->{-surface});
}

sub height {
	my $self = shift;
	return SDL::SurfaceH($self->{-surface});
}

sub pitch {
	my $self = shift;
	return SDL::SurfacePitch($self->{-surface});
}

sub pixels {
	my $self = shift;
	return SDL::SurfacePixels($self->{-surface});
}

sub pixel {
	my $self = shift;
	if ( 3 == @_ ) {
		my ($x, $y, $color) = @_;
		return SDL::SurfacePixel($self->{-surface},$x,$y,$color);
	} else {
		my ($x,$y) = @_;		
		return SDL::SurfacePixel($self->{-surface},$x,$y);
	}
}

sub fill {
	my $self = shift;
	my $rect = shift;
	my $color = shift;
	return SDL::FillRect($self->{-surface},$rect->{-rect},$color);
}

sub lockp {
	my $self = shift;
	return SDL::MUSTLOCK($self->{-surface});
}

sub lock {
	my $self = shift;
	return SDL::SurfaceLock($self->{-surface});
}

sub unlock {
	my $self = shift;
	return SDL::SurfaceUnlock($self->{-surface});
}

sub update {
	my $self = shift;
	my @irects = @_;
	my @rects;
	my $rect;
	
	for $rect (@irects) { push @rects, $rect->{-rect}; }
	SDL::UpdateRects($self->{-surface}, @rects );
}

sub flip {
	my $self = shift;
	SDL::Flip($self->{-surface});
}

sub blit {
	my $self = shift;
	my $srect = shift;
	my $dest = shift;
	my $drect = shift;
	return SDL::BlitSurface($self->{-surface},$srect->{-rect},
		$dest->{-surface},$drect->{-rect});
}

sub set_colors {
	my $self = shift;
	my $start = shift;
	return SDL::SetColors($self->{-surface},$start,@_);
}

sub set_color_key {
	my $self = shift;
	my $flag = shift;
	my $pixel = shift;
	return SDL::SetColorKey($self->{-surface},$flag,$pixel);
}

sub set_alpha {
	my $self = shift;
	my $flag = shift;
	my $alpha = shift;
	return SDL::SetAlpha($self->{-surface},$flag,$alpha);
}

sub display_format {
	my $surface = shift;
	my $tmp_surface = SDL::DisplayFormat ($surface->{-surface});
	SDL::FreeSurface ($surface->{-surface});
	$surface->{-surface} = $tmp_surface;
	return $surface;
}

sub print {
	my $self = shift;
	my $x = shift;
	my $y = shift;
	SDL::PutString( $self->{-surface}, $x, $y, join('',@_));
}

sub save_bmp {
	my $self = shift;
	my $filename = shift;
	return SDL::SaveBMP( $self->{-surface}, $filename);
}

sub video_info {
	my $self = shift;
	return SDL::VideoInfo();
}

1;

__END__;

=head1 NAME

SDL::Surface - a SDL perl extension

=head1 SYNOPSIS

  use SDL::Surface;
  $image = new SDL::Surface(-name=>"yomama.jpg");

=head1 DESCRIPTION

To be rewritten...	

=head1 AUTHOR

David J. Goehrig

=head1 SEE ALSO

perl(1) SDL::Rect(3) SDL::Font(3).

=cut

