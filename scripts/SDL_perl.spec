Summary: SDL_perl Multimedia Perl Extension
Name: SDL_Perl
Version: 2.0.4
Release: 1
License: LGPL GNU Library General Public License
Vendor: sdl.perl.org
Packager: sdl.perl.org
Group: System Environment/Base
Source: http://search.cpan.org/CPAN/authors/id/D/DG/DGOEHRIG/SDL_Perl-%{version}.tar.gz
URL: http://sdl.perl.org/
BuildRoot: /tmp/rpm/SDL_Perl/%{name}-%{version}-buildroot

%description
SDL_Perl provides multimedia programming support for Perl through
use of the Simple DirectMedia Layer http://www.libsdl.org
It provides both a high level, object orient develpment framework,
and a low level C style API.  SDL_Perl supports a variety of
additional SDL libraries, such as SDL_image, SDL_mixer, SDL_ttf,
and SDL_net.

%prep
%setup -q
%build
perl Makefile.PL PREFIX=$RPM_BUILD_ROOT/usr/local
make 

%install
rm -rf $RPM_BUILD_ROOT
make install 
mkdir -p $RPM_BUILD_ROOT/usr/local/lib/perl5/site_perl/
mv $RPM_BUILD_ROOT/usr/local/lib/site_perl/5.6.1/i686-linux/* $RPM_BUILD_ROOT/usr/local/lib/perl5/site_perl/
rm -rf $RPM_BUILD_ROOT/lib/site_perl
rm -rf $RPM_BUILD_ROOT/lib/5.6.1

%clean 
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%dir /usr/local/man/man3/
/usr/local/lib/perl5/site_perl/SDL
/usr/local/lib/perl5/site_perl/auto/SDL
/usr/local/lib/perl5/site_perl/auto/SDL_perl
/usr/local/lib/perl5/site_perl/SDL.pm
/usr/local/lib/perl5/site_perl/SDL_perl.pm
/usr/local/man/*/*

%changelog
* Thu Feb 5 2004 David J. Goehrig <dgoehrig@cpan.org>
- updated spec file for 2.0.4 release

* Thu Apr 5 2002 David J. Goehrig <dave@sdlperl.org>

* Thu Apr 4 2002 David J. Goehrig <dave@sdlperl.org>
- wrote spec file


