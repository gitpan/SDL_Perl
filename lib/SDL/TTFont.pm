#	TTFont.pm
#
#	a SDL perl extension for SDL_ttf support
#
#	Copyright (C) David J. Goehrig 2002
#

package SDL::TTFont;

use strict;
use SDL;
use SDL::Surface;
use SDL::Color;
use SDL::Rect;

use vars qw/ @ISA /;

@ISA = qw(SDL::Surface);

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self = {};
	my %options;
	(%options) = @_;
	$self->{-mode} = $options{-mode} 	|| $options{-m}	 || SDL::TTF_TEXT_SHADED();
	$self->{-name} = $options{-name} 	|| $options{-n};
	$self->{-size} = $options{-size} 	|| $options{-s};
	$self->{-fg} = $options{-foreground} 	|| $options{-fg} || $SDL::Color::black;
	$self->{-bg} = $options{-background}	|| $options{-bg} || $SDL::Color::white;

	die "SDL::TTFont::new requires a -name\n"
		unless ($$self{-name});

	die "SDL::TTFont::new requires a -size\n"
		unless ($$self{-size});

	$self->{-font} = SDL::TTFOpenFont($self->{-name},$self->{-size});

	die "Could not open font $$self{-name}, ", SDL::GetError(), "\n"
		unless ($self->{-font});

	bless $self,$class;
	return $self;	
}

sub DESTROY {
	my $self = shift;
	SDL::FreeSurface($self->{-surface});
	SDL::TTFCloseFont($self->{-font});
}

sub print {
	my ($self,$surface,$x,$y,@text) = @_;

	$surface = $$surface{-surface} if ( ref($surface) && $surface->isa("SDL::Surface"));

	SDL::FreeSurface($self->{-surface}) if ($$self{-surface});

	$$self{-surface} = SDL::TTFPutString($$self{-font},$$self{-mode},
		$surface,$x,$y,$$self{-fg}{-color},$$self{-bg}{-color},join("",@text));

	die "Could not print \"", join("",@text), "\" to surface, ",
		SDL::GetError(), "\n" unless ($$self{-surface});
}

sub normal {
	my ($self) = @_;
	SDL::TTFSetFontStyle($$self{-font},SDL::TTF_STYLE_NORMAL());
}

sub bold {
	my ($self) = @_;
	SDL::TTFSetFontStyle($$self{-font},SDL::TTF_STYLE_BOLD());
}

sub italic {
	my ($self) = @_;
	SDL::TTFSetFontStyle($$self{-font},SDL::TTF_STYLE_ITALIC());

}

sub underline {
	my ($self) = @_;
	SDL::TTFSetFontStyle($$self{-font},SDL::TTF_STYLE_UNDERLINE());
}

sub text_shaded {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_TEXT_SHADED();
}

sub text_solid {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_TEXT_SOLID();
}

sub text_blended {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_TEXT_BLENDED();
}

sub utf8_shaded {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_UTF8_SHADED();
}

sub utf8_solid {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_UTF8_SOLID();
}

sub utf8_blended {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_UTF8_BLENDED();
}

sub unicode_shaded {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_UNICODE_SHADED();
}

sub unicode_solid {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_UNICODE_SOLID();
}

sub unicode_blended {
	my ($self) = @_;
	$$self{-mode} = SDL::TTF_UNICODE_BLENDED();
}

die "Could not initialize True Type Fonts\n"
	if ( SDL::TTFInit() < 0);

1;

__END__;

=head1 NAME

SDL::TTFont - a SDL perl extension

=head1 SYNOPSIS

  $font = new TTFont -name => "Utopia.ttf", -size => 18;
	
=head1 DESCRIPTION



=head1 AUTHOR

David J. Goehrig

=head1 SEE ALSO

perl(1) SDL::Surface(3)

=cut
