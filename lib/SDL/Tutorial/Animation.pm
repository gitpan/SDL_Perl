package SDL::Tutorial::Animation;

use Pod::ToDemo <<'END_HERE';
use SDL::App;
use SDL::Rect;
use SDL::Color;

# change these values as necessary
my $title                                = 'My SDL Animation';
my ($width,      $height,      $depth)   = (  640,  480,   16 );
my ($bg_r,       $bg_g,        $bg_b)    = ( 0x00, 0x00, 0x00 );
my ($rect_r,     $rect_g,      $rect_b)  = ( 0x00, 0x00, 0xff ); 
my ($rect_width, $rect_height, $rect_y)  = (  100,  100,  190 );

my $app = SDL::App->new(
	-width  => $width,
	-height => $height,
	-depth  => $depth,
);

my $color = SDL::Color->new(
	-r => $rect_r,
	-g => $rect_g,
	-b => $rect_b,
);

my $bg_color = SDL::Color->new(
	-r => $bg_r,
	-g => $bg_g,
	-b => $bg_b,
);

my $background = SDL::Rect->new(
	-width  => $width,
	-height => $height,
);

my $rect = create_rect();

# your code here, perhaps
for my $x (0 .. 640)
{
	$rect->x( $x );
	draw_frame( $app,
		bg   => $background, bg_color   => $bg_color,
		rect => $rect,       rect_color => $color,
	);
}

# remove this line
sleep 2;

# XXX - if you know why I need to create a new rect here, please tell me!
$rect        = create_rect();
my $old_rect = create_rect();

# your code also here, perhaps
for my $x (0 .. 640)
{
	$rect->x( $x );
	draw_undraw_rect( $app,
		rect       => $rect,  old_rect => $old_rect,
		rect_color => $color, bg_color => $bg_color, 
	);
	$old_rect->x( $x );
}

# your code almost certainly follows; remove this line
sleep 2;

sub create_rect
{
	return SDL::Rect->new(
		-height => $rect_height,
		-width  => $rect_width,
		-x      => 0,
		-y      => $rect_y,
	);
}

sub draw_frame
{
	my ($app, %args) = @_;

	$app->fill(   $args{bg},   $args{bg_color}   );
	$app->fill(   $args{rect}, $args{rect_color} );
	$app->update( $args{bg} );
}

sub draw_undraw_rect
{
	my ($app, %args) = @_;

	$app->fill(   $args{old_rect}, $args{bg_color}   );
	$app->fill(   $args{rect},     $args{rect_color} );
	$app->update( $args{old_rect} );
	$app->update( $args{rect} );
}
END_HERE

1;
__END__

=head1 NAME

SDL::Tutorial::Animation

=head1 SYNOPSIS

	# to read this tutorial
	$ perldoc SDL::Tutorial::Animation

	# to create a demo animation program based on this tutorial
	$ perl -MSDL::Tutorial::Animation=sdl_anim.pl -e 1

=head1 ANIMATING A RECTANGLE

Now that you can display a rectangle on the screen, the next step is to animate
that rectangle.  As with movies, there's no actual motion.  Computer animations are just very very fast slideshows.  The hard work is creating nearly identical images in every slide (or frame, in graphics terms).

Okay, it's not that difficult.

There is one small difficulty to address, however.  Once you blit one surface
onto another, the destination is changed permanently.  There's no concept of
layers here unless you write it yourself.  If you fail to take this into
account (and just about everyone does at first), you'll end up with blurry
graphics moving around on the screen.

There are two approaches to solve this problem, redrawing the screen on every
frame and saving and restoring the background for every object drawn.

=head2 Redrawing the Screen

Since you have to draw the screen in the right order once to start with it's
pretty easy to make this into a loop and redraw things in the right order for
every frame.  Given a L<SDL::App> object C<$app>, a L<SDL::Rect> C<$rect>, and
a L<SDL::Color> C<$color>, you only have to create a new SDL::Rect C<$bg>,
representing the whole of the background surface and a new SDL::Color
C<$bg_color>, representing the background color.  You can write a
C<draw_frame()> function as follows:

	sub draw_frame
	{
		my ($app, %args) = @_;

		$app->fill( $args{ bg }, $args{ bg_color } );
		$app->fill( $args{rect}, $args{rect_color} );
		$app->update( $args{bg} );
	}

Since you can change the C<x> and C<y> coordinates of a rect with the C<x()>
and C<y()> methods, you can move a rectangle across the screen with a loop like
this:

	for my $x (0 .. 640)
	{
		$rect->x( $x );
		draw_frame( $app,
			bg   => $bg,   bg_color   => $bg_color,
			rect => $rect, rect_color => $color,
		);
	}

If C<$rect>'s starting y position is 190 and its height and width are 100, the
rectangle (er, square) will move across the middle of the screen.

Provided you can keep track of the proper order in which to redraw rectangles
and provided you don't need the optimal speed necessary (since blitting every
object takes more work than just blitting the portions you need), this works
quite well.

=head2 Undrawing the Updated Rectangle

If you need more speed or want to make a different complexity tradeoff, you can
take a snapshot of the destination rectangle I<before> you blit onto it.  That
way, when you need to redraw, you can blit the old snapshot back before
blitting to the new position.

B<Note:>  I have no idea how this will work in the face of alpha blending,
which, admittedly, I haven't even mentioned yet.  If you don't know what this
means, forget it.  If you do know what this means and know why I'm waving my
hands here, feel free to explain what should and what does happen and why.  :)

With this technique, the frame-drawing subroutine has to be a little more
complicated.  Instead of the background rect, it needs a rect for the previous
position.  It also needs to do two updates (or must perform some scary math to
figure out the rectangle of the correct size to C<update()>.  No thanks!).

	sub undraw_redraw_rect
	{
		my ($app, %args) = @_;

		$app->fill(   $args{old_rect}, $args{bg_color}   );
		$app->fill(   $args{rect],     $args{rect_color} );
		$app->update( $args{old_rect}, $args{rect}       );
	}

We'll need to create a new SDL::Rect, C<$old_rect>, that is a duplicate of
C<$rect>, at the same position at first.  You should already know how to do
this.

As before, the loop to call C<undraw_redraw_rect()> would look something like:

	for my $x (0 .. 640)
	{
		$rect->x( $x );

		undraw_redraw_rect( $app,
			rect       => $rect,  old_rect => $old_rect,
			rect_color => $color, bg_color => $bgcolor,
		);

		$old_rect->x( $x );
	}

If you run this code, you'll probably notice that it's tremendously faster than
the previous version.  It may be too fast, where the alternate technique was
just fast enough.  There are a couple of good ways to set a fixed animation
speed regardless of the speed of the processor and graphics hardware (provided
they're good enough, which is increasingly often the case), and we'll get to
them soon.

=head1 SEE ALSO

=over 4

=item L<SDL::Tutorial::Drawing>

basic drawing with SDL Perl

=item L<SDL::Tutorial::Images>

animating images

=back

=head1 AUTHOR

chromatic, E<lt>chromatic@wgz.orgE<gt>

Written for and maintained by the Perl SDL project, L<http://sdl.perl.org/>.

=head1 BUGS

No known bugs.

=head1 COPYRIGHT

Copyright (c) 2003 - 2004, chromatic.  All rights reserved.  This module is
distributed under the same terms as Perl itself, in the hope that it is useful
but certainly under no guarantee.
