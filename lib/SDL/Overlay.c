/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.2002 from the
 * contents of Overlay.xs. Do not edit this file, edit Overlay.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "lib/SDL/Overlay.xs"
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifndef aTHX_
#define aTHX_
#endif

#include <SDL.h>

#line 21 "lib/SDL/Overlay.c"
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

#line 64 "lib/SDL/Overlay.c"

XS(XS_SDL__Overlay_new); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Overlay_new)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 5)
       croak_xs_usage(cv,  "CLASS, width, height, format, display");
    {
	char*	CLASS = (char *)SvPV_nolen(ST(0));
	int	width = (int)SvIV(ST(1));
	int	height = (int)SvIV(ST(2));
	Uint32	format = (Uint32)SvUV(ST(3));
	SDL_Surface *	display;
	SDL_Overlay *	RETVAL;

	if( sv_isobject(ST(4)) && (SvTYPE(SvRV(ST(4))) == SVt_PVMG) )
		{ display = (SDL_Surface *)SvIV((SV*)SvRV( ST(4) )); }
	else if (ST(4) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 37 "lib/SDL/Overlay.xs"
		RETVAL = SDL_CreateYUVOverlay(width, height, format, display);
#line 93 "lib/SDL/Overlay.c"
	ST(0) = sv_newmortal();
	sv_setref_pv( ST(0), CLASS, (void*)RETVAL );


    }
    XSRETURN(1);
}


XS(XS_SDL__Overlay_w); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Overlay_w)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "overlay");
    {
	SDL_Overlay*	overlay;
	int	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ overlay = (SDL_Overlay *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 45 "lib/SDL/Overlay.xs"
		RETVAL = overlay->w;
#line 127 "lib/SDL/Overlay.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Overlay_h); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Overlay_h)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "overlay");
    {
	SDL_Overlay*	overlay;
	int	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ overlay = (SDL_Overlay *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 53 "lib/SDL/Overlay.xs"
		RETVAL = overlay->h;
#line 158 "lib/SDL/Overlay.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Overlay_planes); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Overlay_planes)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "overlay");
    {
	SDL_Overlay*	overlay;
	int	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ overlay = (SDL_Overlay *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 61 "lib/SDL/Overlay.xs"
		RETVAL = overlay->planes;
#line 189 "lib/SDL/Overlay.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Overlay_hwoverlay); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Overlay_hwoverlay)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "overlay");
    {
	SDL_Overlay*	overlay;
	Uint32	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ overlay = (SDL_Overlay *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 69 "lib/SDL/Overlay.xs"
		RETVAL = overlay->hw_overlay;		
#line 220 "lib/SDL/Overlay.c"
	XSprePUSH; PUSHu((UV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Overlay_format); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Overlay_format)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "overlay");
    {
	SDL_Overlay*	overlay;
	Uint32	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ overlay = (SDL_Overlay *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 77 "lib/SDL/Overlay.xs"
		RETVAL = overlay->format;		
#line 251 "lib/SDL/Overlay.c"
	XSprePUSH; PUSHu((UV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Overlay_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Overlay_DESTROY)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "overlay");
    {
	SDL_Overlay *	overlay;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ overlay = (SDL_Overlay *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 86 "lib/SDL/Overlay.xs"
		SDL_FreeYUVOverlay(overlay);
#line 280 "lib/SDL/Overlay.c"
    }
    XSRETURN_EMPTY;
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_SDL__Overlay); /* prototype to pass -Wmissing-prototypes */
XS(boot_SDL__Overlay)
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

        newXS("SDL::Overlay::new", XS_SDL__Overlay_new, file);
        newXS("SDL::Overlay::w", XS_SDL__Overlay_w, file);
        newXS("SDL::Overlay::h", XS_SDL__Overlay_h, file);
        newXS("SDL::Overlay::planes", XS_SDL__Overlay_planes, file);
        newXS("SDL::Overlay::hwoverlay", XS_SDL__Overlay_hwoverlay, file);
        newXS("SDL::Overlay::format", XS_SDL__Overlay_format, file);
        newXS("SDL::Overlay::DESTROY", XS_SDL__Overlay_DESTROY, file);

    /* Initialisation Section */

#if XSubPPtmpAAAA
#if XSubPPtmpAAAB
#endif
#if XSubPPtmpAAAC
#endif
#if XSubPPtmpAAAD
#endif
#if XSubPPtmpAAAE
#endif
#endif
#if XSubPPtmpAAAF
#if XSubPPtmpAAAG
#endif
#if XSubPPtmpAAAH
#endif
#if XSubPPtmpAAAI
#endif
#if XSubPPtmpAAAJ
#endif
#if XSubPPtmpAAAK
#endif
#if XSubPPtmpAAAL
#endif
#if XSubPPtmpAAAM
#endif
#if XSubPPtmpAAAN
#endif
#if XSubPPtmpAAAO
#endif
#if XSubPPtmpAAAP
#endif
#if XSubPPtmpAAAQ
#endif
#endif
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
#line 364 "lib/SDL/Overlay.c"

    /* End of Initialisation Section */

    if (PL_unitcheckav)
         call_list(PL_scopestack_ix, PL_unitcheckav);
    XSRETURN_YES;
}
