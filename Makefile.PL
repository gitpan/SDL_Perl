#!/usr/bin/env perl

use ExtUtils::MakeMaker;

#
# Configure SDL proper
#

my $sdl_cflags = `sdl-config --cflags`;
my $sdl_libs = `sdl-config --libs`;

#
# Locate optional packages
#

my $sdl_image, $png, $jpeg, $mixer, $gl, $glu; 

my @dirs = ( 	'/usr/local/include/SDL', 
		'/usr/local/include',
		'/usr/include/SDL',
		'/usr/include',
		'/usr/local/include/GL',
		'/usr/include/GL', 
);

for ( @dirs ) {
	$sdl_image = '-DHAVE_SDL_IMAGE' if -e "$_/SDL_image.h";
	$sdl_mixer = '-DHAVE_SDL_MIXER' if -e "$_/SDL_mixer.h";
	$sdl_net = '-DHAVE_SDL_NET' if -e "$_/SDL_net.h";
	$sdl_ttf = '-DHAVE_SDL_TTF' if -e "$_/SDL_ttf.h";
	$png = '-DHAVE_PNG' if -e "$_/png.h";
	$jpeg = '-DHAVE_JPEG' if -e "$_/jpeglib.h";
	$gl = '-DHAVE_GL' if -e "$_/gl.h";
	$glu = '-DHAVE_GLU' if -e "$_/glu.h";	
}

print "Found SDL_image	" . ( $sdl_image ? "yes" : "no" ) . "\n";
print "Found SDL_mixer	" . ( $sdl_mixer ? "yes" : "no" ) . "\n";
print "Found SDL_net	" . ( $sdl_net ? "yes" : "no" ) . "\n";
print "Found SDL_ttf	" . ( $sdl_ttf ? "yes" : "no" ) . "\n";
print "Found libpng	" . ( $png ? "yes" : "no" ) . "\n";
print "Found jpeg	" . ( $jpeg ? "yes" : "no" ) . "\n";
print "Found OpenGL	" . ( $gl ? "yes" : "no" ) . "\n";
print "Found GLUT	" . ( $glu ? "yes" : "no" ) . "\n";

#
# Specify Makefile options
#

%options = (
    'NAME'	=> 'SDL',
    'VERSION_FROM' => 'SDL.pm', 
    'LIBS'	=> [ join( " ",	"$sdl_libs", 
			($sdl_image) ? '-lSDL_image' : "", 
			($png) ? '-lpng' : "",
			($jpeg) ? '-ljpeg' : "", 
			($sdl_mixer) ? '-lSDL_mixer' : "", 
			($sdl_net) ? '-lSDL_net' : "",
			($sdl_ttf) ? '-lSDL_ttf' : "",
			($gl) ? '' : "", 
			($glu) ? '' : ""  )
			],  
    'DEFINE'	=> "$sdl_image $png $jpeg $sdl_mixer $sdl_net $sdl_ttf $gl $glu", 
    'INC'	=> "$sdl_cflags",
    'OBJECT'	=> ($sdl_image ? 'font.o' : "" ) . " SDL.o",
);
    
#
# Write Makefile 
#

WriteMakefile(%options );


