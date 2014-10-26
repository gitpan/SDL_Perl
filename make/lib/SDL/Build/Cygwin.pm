#!/usr/bin/env perl
#
# Cygwin.pm
#
# Copyright (C) 2005 David J. Goehrig <dgoehrig@cpan.org>
#
# ------------------------------------------------------------------------------
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# 
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#
# ------------------------------------------------------------------------------
#
# Please feel free to send questions, suggestions or improvements to:
#
#	David J. Goehrig
#	dgoehrig@cpan.org
#

package SDL::Build::Cygwin;

use base 'SDL::Build';

sub opengl_headers
{
	return GL => 'SDL_opengl.h';
}

sub fetch_includes
{
	return (
	'/usr/local/include'       => '/usr/local/lib',
	'/usr/local/include/gl'    => '/usr/local/lib',
	'/usr/local/include/GL'    => '/usr/local/lib',
	'/usr/local/include/SDL'   => '/usr/local/lib',
	'/usr/local/include/smpeg' => '/usr/local/lib',

	'/usr/include'              => '/usr/lib',
	'/usr/include/gl'           => '/usr/lib',
	'/usr/include/GL'           => '/usr/lib',
	'/usr/include/SDL'          => '/usr/lib',
	'/usr/include/smpeg'        => '/usr/lib',

	'/usr/X11R6/include'        => '/usr/X11R6/lib',
	'/usr/X11R6/include/gl'     => '/usr/X11R6/lib',
	'/usr/X11R6/include/GL'     => '/usr/X11R6/lib',
	);
}

sub build_links
{
	my $self  = shift;
	my $links = $self->SUPER::build_links();

	for my $subsystem (values %$links)
	{
		push @{ $subsystem{ libs } }, '-lpthreads';
	}

	return $links;
}

1;
