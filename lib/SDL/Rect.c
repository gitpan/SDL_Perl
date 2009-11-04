/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.2002 from the
 * contents of Rect.xs. Do not edit this file, edit Rect.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "lib/SDL/Rect.xs"
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifndef aTHX_
#define aTHX_
#endif

#include <SDL.h>

#line 21 "lib/SDL/Rect.c"
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

#line 64 "lib/SDL/Rect.c"

XS(XS_SDL__Rect_new); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Rect_new)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 5)
       croak_xs_usage(cv,  "CLASS, x, y, w, h");
    {
	char*	CLASS = (char *)SvPV_nolen(ST(0));
	Sint16	x = (Sint16)SvIV(ST(1));
	Sint16	y = (Sint16)SvIV(ST(2));
	Uint16	w = (Uint16)SvUV(ST(3));
	Uint16	h = (Uint16)SvUV(ST(4));
	SDL_Rect *	RETVAL;
#line 32 "lib/SDL/Rect.xs"
		RETVAL = (SDL_Rect *) safemalloc (sizeof(SDL_Rect));
		RETVAL->x = x;
		RETVAL->y = y;
		RETVAL->w = w;
		RETVAL->h = h;
#line 89 "lib/SDL/Rect.c"
	ST(0) = sv_newmortal();
	sv_setref_pv( ST(0), CLASS, (void*)RETVAL );


    }
    XSRETURN(1);
}


XS(XS_SDL__Rect_x); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Rect_x)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 1)
       croak_xs_usage(cv,  "rect, ...");
    {
	SDL_Rect *	rect;
	Sint16	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ rect = (SDL_Rect *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 44 "lib/SDL/Rect.xs"
		if (items > 1 ) rect->x = SvIV(ST(1)); 
		RETVAL = rect->x;
#line 124 "lib/SDL/Rect.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Rect_y); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Rect_y)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 1)
       croak_xs_usage(cv,  "rect, ...");
    {
	SDL_Rect *	rect;
	Sint16	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ rect = (SDL_Rect *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 53 "lib/SDL/Rect.xs"
		if (items > 1 ) rect->y = SvIV(ST(1)); 
		RETVAL = rect->y;
#line 156 "lib/SDL/Rect.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Rect_w); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Rect_w)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 1)
       croak_xs_usage(cv,  "rect, ...");
    {
	SDL_Rect *	rect;
	Uint16	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ rect = (SDL_Rect *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 62 "lib/SDL/Rect.xs"
		if (items > 1 ) rect->w = SvIV(ST(1)); 
		RETVAL = rect->w;
#line 188 "lib/SDL/Rect.c"
	XSprePUSH; PUSHu((UV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Rect_h); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Rect_h)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 1)
       croak_xs_usage(cv,  "rect, ...");
    {
	SDL_Rect *	rect;
	Uint16	RETVAL;
	dXSTARG;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ rect = (SDL_Rect *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 71 "lib/SDL/Rect.xs"
		if (items > 1 ) rect->h = SvIV(ST(1)); 
		RETVAL = rect->h;
#line 220 "lib/SDL/Rect.c"
	XSprePUSH; PUSHu((UV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_SDL__Rect_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS(XS_SDL__Rect_DESTROY)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "self");
    {
	SDL_Rect *	self;

	if( sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG) )
		{ self = (SDL_Rect *)SvIV((SV*)SvRV( ST(0) )); }
	else if (ST(0) == 0)
	{ XSRETURN(0); }
	else{
		XSRETURN_UNDEF;
	};
#line 81 "lib/SDL/Rect.xs"
		safefree( (char *)self );
#line 249 "lib/SDL/Rect.c"
    }
    XSRETURN_EMPTY;
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_SDL__Rect); /* prototype to pass -Wmissing-prototypes */
XS(boot_SDL__Rect)
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

        newXS("SDL::Rect::new", XS_SDL__Rect_new, file);
        newXS("SDL::Rect::x", XS_SDL__Rect_x, file);
        newXS("SDL::Rect::y", XS_SDL__Rect_y, file);
        newXS("SDL::Rect::w", XS_SDL__Rect_w, file);
        newXS("SDL::Rect::h", XS_SDL__Rect_h, file);
        newXS("SDL::Rect::DESTROY", XS_SDL__Rect_DESTROY, file);

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
#line 314 "lib/SDL/Rect.c"

    /* End of Initialisation Section */

    if (PL_unitcheckav)
         call_list(PL_scopestack_ix, PL_unitcheckav);
    XSRETURN_YES;
}

