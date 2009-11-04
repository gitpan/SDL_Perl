/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.2002 from the
 * contents of SFont.xs. Do not edit this file, edit SFont.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "lib/SDL/SFont.xs"
//
// SFont.xs
//
// Original SFont code Copyright (C) Karl Bartel 
// Copyright (C) 2005 David J. Goehrig <dgoehrig@cpan.org>
//
// ------------------------------------------------------------------------------
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
//
// ------------------------------------------------------------------------------
//
// Please feel free to send questions, suggestions or improvements to:
//
//	David J. Goehrig
//	dgoehrig@cpan.org
//

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifndef aTHX_
#define aTHX_
#endif

#include <SDL.h>
#include <string.h>
#include <stdlib.h>

#ifdef USE_THREADS
#define HAVE_TLS_CONTEXT
#endif

#include "../../src/defines.h"
#include "../../src/SFont.h"

#ifdef HAVE_SDL_IMAGE
#include <SDL_image.h>

SFont_FontInfo InternalFont;
Uint32 SFont_GetPixel(SDL_Surface *Surface, Sint32 X, Sint32 Y)
{

   Uint8  *bits;
   Uint32 Bpp;
   if (X<0) puts("SFONT ERROR: x too small in SFont_GetPixel. Report this to <karlb@gmx.net>");
   if (X>=Surface->w) puts("SFONT ERROR: x too big in SFont_GetPixel. Report this to <karlb@gmx.net>");
   
   Bpp = Surface->format->BytesPerPixel;

   bits = ((Uint8 *)Surface->pixels)+Y*Surface->pitch+X*Bpp;

   // Get the pixel
   switch(Bpp) {
      case 1:
         return *((Uint8 *)Surface->pixels + Y * Surface->pitch + X);
         break;
      case 2:
         return *((Uint16 *)Surface->pixels + Y * Surface->pitch/2 + X);
         break;
      case 3: { // Format/endian independent 
         Uint8 r, g, b;
         r = *((bits)+Surface->format->Rshift/8);
         g = *((bits)+Surface->format->Gshift/8);
         b = *((bits)+Surface->format->Bshift/8);
         return SDL_MapRGB(Surface->format, r, g, b);
         }
         break;
      case 4:
         return *((Uint32 *)Surface->pixels + Y * Surface->pitch/4 + X);
         break;
   }

    return -1;
}

void SFont_InitFont2(SFont_FontInfo *Font)
{
    int x = 0, i = 0;

    if ( Font->Surface==NULL ) {
	printf("The font has not been loaded!\n");
	exit(1);
    }

    if (SDL_MUSTLOCK(Font->Surface)) SDL_LockSurface(Font->Surface);

    while ( x < Font->Surface->w ) {
	if(SFont_GetPixel(Font->Surface,x,0)==SDL_MapRGB(Font->Surface->format,255,0,255)) { 
    	    Font->CharPos[i++]=x;
    	    while (( x < Font->Surface->w-1) && (SFont_GetPixel(Font->Surface,x,0)==SDL_MapRGB(Font->Surface->format,255,0,255)))
		x++;
	    Font->CharPos[i++]=x;
	}
	x++;
    }
    if (SDL_MUSTLOCK(Font->Surface)) SDL_UnlockSurface(Font->Surface);

    Font->h=Font->Surface->h;
    SDL_SetColorKey(Font->Surface, SDL_SRCCOLORKEY, SFont_GetPixel(Font->Surface, 0, Font->Surface->h-1));
}

void SFont_InitFont(SDL_Surface *Font)
{
    InternalFont.Surface=Font;
    SFont_InitFont2(&InternalFont);
}

void SFont_PutString2(SDL_Surface *Surface, SFont_FontInfo *Font, int x, int y, char *text)
{
    int ofs;
    int i=0;
    SDL_Rect srcrect,dstrect; 

    while (text[i]!='\0') {
        if (text[i]==' ') {
            x+=Font->CharPos[2]-Font->CharPos[1];
            i++;
	}
	else {
//	    printf("-%c- %c - %u\n",228,text[i],text[i]);
	    ofs=(text[i]-33)*2+1;
//	    printf("printing %c %d\n",text[i],ofs);
            srcrect.w = dstrect.w = (Font->CharPos[ofs+2]+Font->CharPos[ofs+1])/2-(Font->CharPos[ofs]+Font->CharPos[ofs-1])/2;
            srcrect.h = dstrect.h = Font->Surface->h-1;
            srcrect.x = (Font->CharPos[ofs]+Font->CharPos[ofs-1])/2;
            srcrect.y = 1;
    	    dstrect.x = x-(float)(Font->CharPos[ofs]-Font->CharPos[ofs-1])/2;
	    dstrect.y = y;

	    SDL_BlitSurface( Font->Surface, &srcrect, Surface, &dstrect); 

            x+=Font->CharPos[ofs+1]-Font->CharPos[ofs];
            i++;
        }
    }
}

void SFont_PutString(SDL_Surface *Surface, int x, int y, char *text)
{
    SFont_PutString2(Surface, &InternalFont, x, y, text);
}

int SFont_TextWidth2(SFont_FontInfo *Font, char *text)
{
    int ofs=0;
    int i=0,x=0;

    while (text[i]!='\0') {
        if (text[i]==' ') {
            x+=Font->CharPos[2]-Font->CharPos[1];
            i++;
	}
	else {
	    ofs=(text[i]-33)*2+1;
            x+=Font->CharPos[ofs+1]-Font->CharPos[ofs];
            i++;
        }
    }
//    printf ("--%d\n",x);
    return x;
}

int SFont_TextWidth(char *text)
{
    return SFont_TextWidth2(&InternalFont, text);
}

void SFont_XCenteredString2(SDL_Surface *Surface, SFont_FontInfo *Font, int y, char *text)
{
    SFont_PutString2(Surface, Font, Surface->w/2-SFont_TextWidth2(Font,text)/2, y, text);
}

void SFont_XCenteredString(SDL_Surface *Surface, int y, char *text)
{
    SFont_XCenteredString2(Surface, &InternalFont, y, text);
}

void SFont_InternalInput( SDL_Surface *Dest, SFont_FontInfo *Font, int x, int y, int PixelWidth, char *text)
{
    SDL_Event event;
    int ch=-1,blink=0;
    long blinktimer=0;
    SDL_Surface *Back;
    SDL_Rect rect;
    int previous;
//    int ofs=(text[0]-33)*2+1;
//    int leftshift=(Font->CharPos[ofs]-Font->CharPos[ofs-1])/2;
    
    Back = SDL_AllocSurface(Dest->flags,
    			    Dest->w,
    			    Font->h,
    			    Dest->format->BitsPerPixel,
    			    Dest->format->Rmask,
    			    Dest->format->Gmask,
			    Dest->format->Bmask, 0);
    rect.x=0;
    rect.y=y;
    rect.w=Dest->w;
    rect.h=Font->Surface->h;
    SDL_BlitSurface(Dest, &rect, Back, NULL);
    SFont_PutString2(Dest,Font,x,y,text);
    SDL_UpdateRects(Dest, 1, &rect);
        
    // start input
    previous=SDL_EnableUNICODE(1);
    blinktimer=SDL_GetTicks();
    while (ch!=SDLK_RETURN) {
	if (event.type==SDL_KEYDOWN) {
	    ch=event.key.keysym.unicode;
	    if (((ch>31)||(ch=='\b')) && (ch<128)) {
		if ((ch=='\b')&&(strlen(text)>0))
		    text[strlen(text)-1]='\0';
		else if (ch!='\b')
		    sprintf(text+strlen(text),"%c",ch);
	        if (SFont_TextWidth2(Font,text)>PixelWidth) text[strlen(text)-1]='\0';
		SDL_BlitSurface( Back, NULL, Dest, &rect);
		SFont_PutString2(Dest, Font, x, y, text);
		SDL_UpdateRects(Dest, 1, &rect);
//		printf("%s ## %d\n",text,strlen(text));
		SDL_WaitEvent(&event);
	    }
	}
	if (SDL_GetTicks()>blinktimer) {
	    blink=1-blink;
	    blinktimer=SDL_GetTicks()+500;
	    if (blink) {
		SFont_PutString2(Dest, Font, x+SFont_TextWidth2(Font,text), y, "|");
		SDL_UpdateRects(Dest, 1, &rect);
//		SDL_UpdateRect(Dest, x+SFont_TextWidth2(Font,text), y, SFont_TextWidth2(Font,"|"), Font->Surface->h);
	    } else {
		SDL_BlitSurface( Back, NULL, Dest, &rect);
		SFont_PutString2(Dest, Font, x, y, text);
		SDL_UpdateRects(Dest, 1, &rect);
//		SDL_UpdateRect(Dest, x-(Font->CharPos[ofs]-Font->CharPos[ofs-1])/2, y, PixelWidth, Font->Surface->h);
	    }
	}
	SDL_Delay(1);
	SDL_PollEvent(&event);
    }
    text[strlen(text)]='\0';
    SDL_FreeSurface(Back);
    SDL_EnableUNICODE(previous);  //restore the previous state
}

void SFont_Input2( SDL_Surface *Dest, SFont_FontInfo *Font, int x, int y, int PixelWidth, char *text)
{
    SFont_InternalInput( Dest, Font, x, y, PixelWidth,  text);
}
void SFont_Input( SDL_Surface *Dest, int x, int y, int PixelWidth, char *text)
{
    SFont_Input2( Dest, &InternalFont, x, y, PixelWidth, text);
}

#endif

#line 280 "lib/SDL/SFont.c"
#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#ifndef PERL_ARGS_ASSERT_CROAK_XS_USAGE
#define PERL_ARGS_ASSERT_CROAK_XS_USAGE assert(cv); assert(params)

/* prototype to pass -Wmissing-prototypes */
STATIC void
S_croak_xs_usage(pTHX_ const CV *const cv, const char *const params);

STATIC void
S_croak_xs_usage(pTHX_ const CV *const cv, const char *const params)
{
    const GV *const gv = CvGV(cv);

    PERL_ARGS_ASSERT_CROAK_XS_USAGE;

    if (gv) {
        const char *const gvname = GvNAME(gv);
        const HV *const stash = GvSTASH(gv);
        const char *const hvname = stash ? HvNAME(stash) : NULL;

        if (hvname)
            Perl_croak(aTHX_ "Usage: %s::%s(%s)", hvname, gvname, params);
        else
            Perl_croak(aTHX_ "Usage: %s(%s)", gvname, params);
    } else {
        /* Pants. I don't think that it should be possible to get here. */
        Perl_croak(aTHX_ "Usage: CODE(0x%"UVxf")(%s)", PTR2UV(cv), params);
    }
}
#undef  PERL_ARGS_ASSERT_CROAK_XS_USAGE

#ifdef PERL_IMPLICIT_CONTEXT
#define croak_xs_usage(a,b)	S_croak_xs_usage(aTHX_ a,b)
#else
#define croak_xs_usage		S_croak_xs_usage
#endif

#endif

#line 323 "lib/SDL/SFont.c"
#ifdef HAVE_SDL_IMAGE
#define XSubPPtmpAAAA 1


XS(XS_SDL__SFont_NewFont); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__SFont_NewFont)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "filename");
    {
	char *	filename = (char *)SvPV_nolen(ST(0));
	SDL_Surface *	RETVAL;
	dXSTARG;
#line 279 "lib/SDL/SFont.xs"
		RETVAL = IMG_Load(filename);
		SFont_InitFont(RETVAL);
#line 345 "lib/SDL/SFont.c"
	XSprePUSH; PUSHi(PTR2IV(RETVAL));
    }
    XSRETURN(1);
}


XS(XS_SDL__SFont_UseFont); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__SFont_UseFont)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "surface");
    {
	SDL_Surface *	surface = INT2PTR(SDL_Surface *,SvIV(ST(0)));
#line 288 "lib/SDL/SFont.xs"
		SFont_InitFont(surface);
#line 366 "lib/SDL/SFont.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_SDL__SFont_PutString); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__SFont_PutString)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 4)
       croak_xs_usage(cv,  "surface, x, y, text");
    {
	SDL_Surface *	surface = INT2PTR(SDL_Surface *,SvIV(ST(0)));
	int	x = (int)SvIV(ST(1));
	int	y = (int)SvIV(ST(2));
	char *	text = (char *)SvPV_nolen(ST(3));
#line 297 "lib/SDL/SFont.xs"
		SFont_PutString( surface, x, y, text );
#line 389 "lib/SDL/SFont.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_SDL__SFont_TextWidth); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__SFont_TextWidth)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "text");
    {
	char *	text = (char *)SvPV_nolen(ST(0));
	int	RETVAL;
	dXSTARG;
#line 303 "lib/SDL/SFont.xs"
                RETVAL = SFont_TextWidth(text);
#line 411 "lib/SDL/SFont.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}

#endif
#ifdef __cplusplus
extern "C"
#endif
XS(boot_SDL__SFont); /* prototype to pass -Wmissing-prototypes */
XS(boot_SDL__SFont)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    const char* file = __FILE__;

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
    XS_VERSION_BOOTCHECK ;

#if XSubPPtmpAAAA
        newXS("SDL::SFont::NewFont", XS_SDL__SFont_NewFont, file);
        newXS("SDL::SFont::UseFont", XS_SDL__SFont_UseFont, file);
        newXS("SDL::SFont::PutString", XS_SDL__SFont_PutString, file);
        newXS("SDL::SFont::TextWidth", XS_SDL__SFont_TextWidth, file);
#endif

    /* Initialisation Section */

#if XSubPPtmpAAAA
#endif
#if XSubPPtmpAAAB
#endif
#if XSubPPtmpAAAC
#endif
#if XSubPPtmpAAAD
#endif
#if XSubPPtmpAAAE
#endif
#if XSubPPtmpAAAF
#endif
#if XSubPPtmpAAAG
#endif
#if XSubPPtmpAAAH
#endif
#if XSubPPtmpAAAA
#endif
#line 462 "lib/SDL/SFont.c"

    /* End of Initialisation Section */

    if (PL_unitcheckav)
         call_list(PL_scopestack_ix, PL_unitcheckav);
    XSRETURN_YES;
}
