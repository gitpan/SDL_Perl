#!/usr/bin/env perl

use SDL::App;
use SDL::Surface;
use SDL::Event;
use SDL::Font;

$app = new SDL::App 
			-width => 600, 
			-height => 300, 
			-title => "happy",
			-icon => "wilbur.png";

$font = new SDL::Font "Font.png";
$app->print(10, 10, "Hello ","World");
$app->flip;
for $i (1..4) {
	$app->print( SDL_TEXTWIDTH("Hello World") + SDL_TEXTWIDTH("..$i..")*$i, 
		 35 * $i, "..$i..");
	$app->flip;
}

$e = new SDL::Event;

while (1) {
	$e->wait;
	if ($e->type == SDL_QUIT ) { last; }
}
