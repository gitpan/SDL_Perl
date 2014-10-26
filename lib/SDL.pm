#!/usr/bin/env perl
#
# SDL.pm
#
# Copyright (C) 2005 David J. Goehrig <dgoehrig@cpan.org>
# Copyright (C) 2009 Kartik Thakore   <kthakore@cpan.org>
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
#	Kartik Thakore
#	kthakore@cpan.org
#

package SDL;

use strict;
use warnings;
use Carp;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;
require DynaLoader;

use SDL_perl;
use SDL::Constants;

BEGIN {
	@ISA = qw(Exporter DynaLoader);
	@EXPORT = qw( in verify &NULL );
};

# Give our caller SDL::Constant's stuff as well as ours.
sub import {
  my $self = shift;

  $self->export_to_level(1, @_);
  SDL::Constants->export_to_level(1);
}
our $VERSION = '2.3_0'; #Development Release
$VERSION = eval $VERSION;

print "$VERSION" if (defined($ARGV[0]) && ($ARGV[0] eq '--SDLperl'));

$SDL::DEBUG=0;

sub NULL {
	return 0;
}

sub in {
	my ($k,@t) = @_;
	return 0 unless defined $k;
	my $r = ((scalar grep { defined $_ && $_ eq $k } @t) <=> 0);
	return 0 if $r eq '';
	return $r;

} 

sub verify (\%@) {
	my ($options,@valid_options) = @_;
	for (keys %$options) {
		croak "Invalid option $_\n" unless in ($_, @valid_options);
	}
}

# workaround as:
# extern DECLSPEC void SDLCALL SDL_SetError(const char *fmt, ...);
sub set_error {
	my($format, @arguments) = @_;
	SDL::set_error_real(sprintf($format, @arguments));
}

1;
