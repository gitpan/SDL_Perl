// SDL.xs
//
// SDL_perl by David J. Goehrig <dave@cthulhu-burger.org>
//
// David J. Goehrig Copyright (C) 2000,2001,2002
//
// This software is under the GNU Library General Public License (LGPL)
// see the file COPYING for terms of use

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <SDL.h>

#ifdef HAVE_SDL_IMAGE
#include <SDL_image.h>
#endif 

#ifdef HAVE_SDL_MIXER
#include <SDL_mixer.h>
#endif

#ifdef HAVE_GL
#include <GL/gl.h>
#endif

#ifdef HAVE_GLU
#include <GL/glu.h>
#endif

#ifdef HAVE_SDL_NET
#include <SDL_net.h>
#endif

#ifdef HAVE_SDL_TTF
#include <SDL_ttf.h>
#endif

Uint32 
sdl_perl_timer_callback ( Uint32 interval, void* param )
{
	SV* cmd = (SV*)param;
	call_sv(cmd,G_VOID|G_DISCARD);
}

MODULE = SDL	PACKAGE = SDL
PROTOTYPES : DISABLE

char *
GetError ()
	CODE:
		RETVAL = SDL_GetError();
	OUTPUT:
		RETVAL

Uint32
INIT_AUDIO ()
	CODE:
		RETVAL = SDL_INIT_AUDIO;
	OUTPUT:
		RETVAL

Uint32
INIT_VIDEO ()
	CODE:
		RETVAL = SDL_INIT_VIDEO;
	OUTPUT:
		RETVAL

Uint32
INIT_CDROM ()
	CODE:
		RETVAL = SDL_INIT_CDROM;
	OUTPUT:
		RETVAL

Uint32
INIT_EVERYTHING ()
	CODE:
		RETVAL = SDL_INIT_EVERYTHING;
	OUTPUT:	
		RETVAL

Uint32
INIT_NOPARACHUTE () 
	CODE:
		RETVAL = SDL_INIT_NOPARACHUTE;
	OUTPUT:
		RETVAL

Uint32
INIT_JOYSTICK ()
	CODE:
		RETVAL = SDL_INIT_JOYSTICK;
	OUTPUT:
		RETVAL
	

int
Init ( flags )
	Uint32 flags
	CODE:
		RETVAL = SDL_Init(flags);
#ifndef DONT_USE_ATEXIT
		atexit(SDL_Quit);
#endif
	OUTPUT:
		RETVAL

int
InitSubSystem ( flags )
	Uint32 flags
	CODE:
		RETVAL = SDL_InitSubSystem(flags);
	OUTPUT:
		RETVAL

void
QuitSubSystem ( flags )
	Uint32 flags
	CODE:
		SDL_QuitSubSystem(flags);

void
Quit ()
	CODE:
		SDL_Quit();

int
WasInit ( flags )
	Uint32 flags
	CODE:
		RETVAL = SDL_WasInit(flags);
	OUTPUT:
		RETVAL

void
Delay ( ms )
	int ms
	CODE:
		SDL_Delay(ms);

Uint32
GetTicks ()
	CODE:
		RETVAL = SDL_GetTicks();
	OUTPUT:
		RETVAL

int
SetTimer ( interval, callback )
	Uint32 interval
	SDL_TimerCallback callback
	CODE:
		RETVAL = SDL_SetTimer(interval,callback);
	OUTPUT:
		RETVAL

SDL_TimerID
AddTimer ( interval, callback, param )
	Uint32 interval
	SDL_NewTimerCallback callback
	void *param
	CODE:
		RETVAL = SDL_AddTimer(interval,callback,param);
	OUTPUT:
		RETVAL

SDL_NewTimerCallback
PerlTimerCallback ()
	CODE:
		RETVAL = sdl_perl_timer_callback;
	OUTPUT:
		RETVAL  

SDL_TimerID
NewTimer ( interval, cmd )
	Uint32 interval
	SV *cmd
	CODE:
		RETVAL = SDL_AddTimer(interval,sdl_perl_timer_callback,(void*)cmd);
	OUTPUT:
		RETVAL

Uint32
RemoveTimer ( id )
	SDL_TimerID id
	CODE:
		RETVAL = SDL_RemoveTimer(id);
	OUTPUT:
		RETVAL

int
CDNumDrives ()
	CODE:
		RETVAL = SDL_CDNumDrives();
	OUTPUT:
		RETVAL

char *
CDName ( drive )
	int drive
	CODE:
		RETVAL = strdup(SDL_CDName(drive));
	OUTPUT:
		RETVAL

SDL_CD *
CDOpen ( drive )
	int drive
	CODE:
		RETVAL = SDL_CDOpen(drive);
	OUTPUT:
		RETVAL

char *
CDTrackListing ( cd )
	SDL_CD *cd
	CODE:
		int i,m,s,f;
		FILE *fp;
		size_t len;
		SDL_CDStatus(cd);
		fp = (FILE *) open_memstream(&RETVAL,&len);
		for (i=0;i<cd->numtracks; ++i) {
			FRAMES_TO_MSF(cd->track[i].length,&m,&s,&f);
			if (f > 0) s++;
			fprintf(fp,"Track index: %d, id: %d, time: %2d.%2d\n",
				i,cd->track[i].id,m,s);
		}
		fclose(fp);
	OUTPUT:
		RETVAL

Uint8
CDTrackId ( track )
	SDL_CDtrack *track
	CODE:
		RETVAL = track->id;
	OUTPUT:
		RETVAL

Uint8
CDTrackType ( track )
	SDL_CDtrack *track
	CODE:
		RETVAL = track->type;
	OUTPUT:
		RETVAL

Uint16
CDTrackLength ( track )
	SDL_CDtrack *track
	CODE:
		RETVAL = track->length;
	OUTPUT:
		RETVAL

Uint32
CDTrackOffset ( track )
	SDL_CDtrack *track
	CODE:
		RETVAL = track->offset;
	OUTPUT: 
		RETVAL

Uint32
CD_TRAYEMPTY ()
	CODE:
		RETVAL = CD_TRAYEMPTY;
	OUTPUT:	
		RETVAL

Uint32
CD_PLAYING ()
	CODE:
		RETVAL = CD_PLAYING;
	OUTPUT:	
		RETVAL

Uint32
CD_STOPPED()
	CODE:
		RETVAL = CD_STOPPED ;
	OUTPUT:	
		RETVAL

Uint32
CD_PAUSED ()
	CODE:
		RETVAL = CD_PAUSED;
	OUTPUT:	
		RETVAL

Uint32
CD_ERROR ()
	CODE:
		RETVAL = CD_ERROR ;
	OUTPUT:	
		RETVAL

Uint32
CDStatus ( cd )
	SDL_CD *cd 
	CODE:
		RETVAL = SDL_CDStatus(cd);
	OUTPUT:
		RETVAL

int
CDPlayTracks ( cd, start_track, ntracks, start_frame, nframes )
	SDL_CD *cd
	int start_track
	int ntracks
	int start_frame
	int nframes
	CODE:
		RETVAL = SDL_CDPlayTracks(cd,start_track,start_frame,ntracks,nframes);
	OUTPUT:
		RETVAL

int
CDPlay ( cd, start, length )
	SDL_CD *cd
	int start
	int length
	CODE:
		RETVAL = SDL_CDPlay(cd,start,length);
	OUTPUT:
		RETVAL

int
CDPause ( cd )
	SDL_CD *cd
	CODE:
		RETVAL = SDL_CDPause(cd);
	OUTPUT:
		RETVAL

int
CDResume ( cd )
	SDL_CD *cd
	CODE:
		RETVAL = SDL_CDResume(cd);
	OUTPUT:
		RETVAL

int
CDStop ( cd )
	SDL_CD *cd
	CODE:
		RETVAL = SDL_CDStop(cd);
	OUTPUT:
		RETVAL

int
CDEject ( cd )
	SDL_CD *cd
	CODE:
		RETVAL = SDL_CDEject(cd);
	OUTPUT:
		RETVAL

void
CDClose ( cd )
	SDL_CD *cd
	CODE:
		SDL_CDClose(cd);
	
int
CDId ( cd )
	SDL_CD *cd
	CODE:
		RETVAL = cd->id;
	OUTPUT: 
		RETVAL

int
CDNumTracks ( cd )
	SDL_CD *cd
	CODE:
		RETVAL = cd->numtracks;
	OUTPUT:
		RETVAL

int
CDCurTrack ( cd )
	SDL_CD *cd
	CODE:
		RETVAL = cd->cur_track;
	OUTPUT:
		RETVAL

int
CDCurFrame ( cd )
	SDL_CD *cd
	CODE:
		RETVAL = cd->cur_frame;
	OUTPUT:
		RETVAL

SDL_CDtrack *
CDTrack ( cd, number )
	SDL_CD *cd
	int number
	CODE:
		RETVAL = (SDL_CDtrack *)(cd->track + number);
	OUTPUT:
		RETVAL

void
PumpEvents ()
	CODE:
		SDL_PumpEvents();

SDL_Event *
NewEvent ()
	CODE:	
		RETVAL = (SDL_Event *) safemalloc (sizeof(SDL_Event));
	OUTPUT:
		RETVAL

void
FreeEvent( e )
	SDL_Event *e
	CODE:
		safefree(e);

int
PollEvent ( e )
	SDL_Event *e
	CODE:
		RETVAL = SDL_PollEvent(e);
	OUTPUT:
		RETVAL

int
WaitEvent ( e )
	SDL_Event *e
	CODE:
		RETVAL = SDL_WaitEvent(e);
	OUTPUT:
		RETVAL

Uint8
EventState ( type, state )
	Uint8 type
	int state
	CODE:
		RETVAL = SDL_EventState(type,state);
	OUTPUT:
		RETVAL 

int
IGNORE ()
	CODE:
		RETVAL = SDL_IGNORE;
	OUTPUT:
		RETVAL

int
ENABLE ()
	CODE:
		RETVAL = SDL_ENABLE;
	OUTPUT:
		RETVAL

int
QUERY ()
	CODE:	
		RETVAL = SDL_QUERY;
	OUTPUT:
		RETVAL

Uint8
ACTIVEEVENT()
	CODE:
		RETVAL = SDL_ACTIVEEVENT;
	OUTPUT:
		RETVAL	

Uint8
KEYDOWN ()
	CODE:
		RETVAL = SDL_KEYDOWN;
	OUTPUT:
		RETVAL	

Uint8
KEYUP ()
	CODE:
		RETVAL = SDL_KEYUP;
	OUTPUT:
		RETVAL	

Uint8
MOUSEMOTION ()
	CODE:
		RETVAL = SDL_MOUSEMOTION;
	OUTPUT:
		RETVAL	

Uint8
MOUSEBUTTONDOWN ()
	CODE:
		RETVAL = SDL_MOUSEBUTTONDOWN;
	OUTPUT:
		RETVAL	

Uint8
MOUSEBUTTONUP ()
	CODE:
		RETVAL = SDL_MOUSEBUTTONUP;
	OUTPUT:
		RETVAL	

Uint8
QUIT ()
	CODE:
		RETVAL = SDL_QUIT;
	OUTPUT:
		RETVAL	

Uint8
SYSWMEVENT ()
	CODE:
		RETVAL = SDL_SYSWMEVENT;
	OUTPUT:
		RETVAL	

Uint8
EventType ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->type;
	OUTPUT:
		RETVAL

Uint8
ActiveEventGain ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->active.gain;
	OUTPUT:	
		RETVAL

Uint8
ActiveEventState ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->active.state;
	OUTPUT:
		RETVAL

Uint8
APPMOUSEFOCUS ()
	CODE:
		RETVAL = SDL_APPMOUSEFOCUS;
	OUTPUT:
		RETVAL

Uint8
APPINPUTFOCUS ()
	CODE:
		RETVAL = SDL_APPINPUTFOCUS;
	OUTPUT:
		RETVAL

Uint8
APPACTIVE ()
	CODE:
		RETVAL = SDL_APPACTIVE;
	OUTPUT:
		RETVAL

Uint8
KeyEventState( e )
	SDL_Event *e
	CODE:
		RETVAL = e->key.state;
	OUTPUT:
		RETVAL

int
SDLK_BACKSPACE ()
	CODE:
		RETVAL = SDLK_BACKSPACE;
	OUTPUT:
		RETVAL

int
SDLK_TAB ()
	CODE:
		RETVAL = SDLK_TAB;
	OUTPUT:
		RETVAL

int
SDLK_CLEAR ()
	CODE:
		RETVAL = SDLK_CLEAR;
	OUTPUT:
		RETVAL

int
SDLK_RETURN ()
	CODE:
		RETVAL = SDLK_RETURN;
	OUTPUT:
		RETVAL

int
SDLK_PAUSE ()
	CODE:
		RETVAL = SDLK_PAUSE;
	OUTPUT:
		RETVAL

int
SDLK_ESCAPE ()
	CODE:
		RETVAL = SDLK_ESCAPE;
	OUTPUT:
		RETVAL

int
SDLK_SPACE ()
	CODE:
		RETVAL = SDLK_SPACE;
	OUTPUT:
		RETVAL

int
SDLK_EXCLAIM ()
	CODE:
		RETVAL = SDLK_EXCLAIM;
	OUTPUT:
		RETVAL

int
SDLK_QUOTEDBL ()
	CODE:
		RETVAL = SDLK_QUOTEDBL;
	OUTPUT:
		RETVAL

int
SDLK_HASH ()
	CODE:
		RETVAL = SDLK_HASH;
	OUTPUT:
		RETVAL

int
SDLK_DOLLAR ()
	CODE:
		RETVAL = SDLK_DOLLAR;
	OUTPUT:
		RETVAL

int
SDLK_AMPERSAND ()
	CODE:
		RETVAL = SDLK_AMPERSAND;
	OUTPUT:
		RETVAL

int
SDLK_QUOTE ()
	CODE:
		RETVAL = SDLK_QUOTE;
	OUTPUT:
		RETVAL

int
SDLK_LEFTPAREN ()
	CODE:
		RETVAL = SDLK_LEFTPAREN;
	OUTPUT:
		RETVAL

int
SDLK_RIGHTPAREN ()
	CODE:
		RETVAL = SDLK_RIGHTPAREN;
	OUTPUT:
		RETVAL

int
SDLK_ASTERISK ()
	CODE:
		RETVAL = SDLK_ASTERISK;
	OUTPUT:
		RETVAL

int
SDLK_PLUS ()
	CODE:
		RETVAL = SDLK_PLUS;
	OUTPUT:
		RETVAL

int
SDLK_COMMA ()
	CODE:
		RETVAL = SDLK_COMMA;
	OUTPUT:
		RETVAL

int
SDLK_MINUS ()
	CODE:
		RETVAL = SDLK_MINUS;
	OUTPUT:
		RETVAL

int
SDLK_PERIOD ()
	CODE:
		RETVAL = SDLK_PERIOD;
	OUTPUT:
		RETVAL

int
SDLK_SLASH ()
	CODE:
		RETVAL = SDLK_SLASH;
	OUTPUT:
		RETVAL

int
SDLK_0 ()
	CODE:
		RETVAL = SDLK_0;
	OUTPUT:
		RETVAL

int
SDLK_1 ()
	CODE:
		RETVAL = SDLK_1;
	OUTPUT:
		RETVAL

int
SDLK_2 ()
	CODE:
		RETVAL = SDLK_2;
	OUTPUT:
		RETVAL

int
SDLK_3 ()
	CODE:
		RETVAL = SDLK_3;
	OUTPUT:
		RETVAL

int
SDLK_4 ()
	CODE:
		RETVAL = SDLK_4;
	OUTPUT:
		RETVAL

int
SDLK_5 ()
	CODE:
		RETVAL = SDLK_5;
	OUTPUT:
		RETVAL

int
SDLK_6 ()
	CODE:
		RETVAL = SDLK_6;
	OUTPUT:
		RETVAL

int
SDLK_7 ()
	CODE:
		RETVAL = SDLK_7;
	OUTPUT:
		RETVAL

int
SDLK_8 ()
	CODE:
		RETVAL = SDLK_8;
	OUTPUT:
		RETVAL

int
SDLK_9 ()
	CODE:
		RETVAL = SDLK_9;
	OUTPUT:
		RETVAL

int
SDLK_COLON ()
	CODE:
		RETVAL = SDLK_COLON;
	OUTPUT:
		RETVAL

int
SDLK_SEMICOLON ()
	CODE:
		RETVAL = SDLK_SEMICOLON;
	OUTPUT:
		RETVAL

int
SDLK_LESS ()
	CODE:
		RETVAL = SDLK_LESS;
	OUTPUT:
		RETVAL

int
SDLK_EQUALS ()
	CODE:
		RETVAL = SDLK_EQUALS;
	OUTPUT:
		RETVAL

int
SDLK_GREATER ()
	CODE:
		RETVAL = SDLK_GREATER;
	OUTPUT:
		RETVAL

int
SDLK_QUESTION ()
	CODE:
		RETVAL = SDLK_QUESTION;
	OUTPUT:
		RETVAL

int
SDLK_AT ()
	CODE:
		RETVAL = SDLK_AT;
	OUTPUT:
		RETVAL

int
SDLK_LEFTBRACKET ()
	CODE:
		RETVAL = SDLK_LEFTBRACKET;
	OUTPUT:
		RETVAL

int
SDLK_BACKSLASH ()
	CODE:
		RETVAL = SDLK_BACKSLASH;
	OUTPUT:
		RETVAL

int
SDLK_RIGHTBRACKET ()
	CODE:
		RETVAL = SDLK_RIGHTBRACKET;
	OUTPUT:
		RETVAL

int
SDLK_CARET ()
	CODE:
		RETVAL = SDLK_CARET;
	OUTPUT:
		RETVAL

int
SDLK_UNDERSCORE ()
	CODE:
		RETVAL = SDLK_UNDERSCORE;
	OUTPUT:
		RETVAL

int
SDLK_BACKQUOTE ()
	CODE:
		RETVAL = SDLK_BACKQUOTE;
	OUTPUT:
		RETVAL

int
SDLK_a ()
	CODE:
		RETVAL = SDLK_a;
	OUTPUT:
		RETVAL

int
SDLK_b ()
	CODE:
		RETVAL = SDLK_b;
	OUTPUT:
		RETVAL

int
SDLK_c ()
	CODE:
		RETVAL = SDLK_c;
	OUTPUT:
		RETVAL

int
SDLK_d ()
	CODE:
		RETVAL = SDLK_d;
	OUTPUT:
		RETVAL

int
SDLK_e ()
	CODE:
		RETVAL = SDLK_e;
	OUTPUT:
		RETVAL

int
SDLK_f ()
	CODE:
		RETVAL = SDLK_f;
	OUTPUT:
		RETVAL

int
SDLK_g ()
	CODE:
		RETVAL = SDLK_g;
	OUTPUT:
		RETVAL

int
SDLK_h ()
	CODE:
		RETVAL = SDLK_h;
	OUTPUT:
		RETVAL

int
SDLK_i ()
	CODE:
		RETVAL = SDLK_i;
	OUTPUT:
		RETVAL

int
SDLK_j ()
	CODE:
		RETVAL = SDLK_j;
	OUTPUT:
		RETVAL

int
SDLK_k ()
	CODE:
		RETVAL = SDLK_k;
	OUTPUT:
		RETVAL

int
SDLK_l ()
	CODE:
		RETVAL = SDLK_l;
	OUTPUT:
		RETVAL

int
SDLK_m ()
	CODE:
		RETVAL = SDLK_m;
	OUTPUT:
		RETVAL

int
SDLK_n ()
	CODE:
		RETVAL = SDLK_n;
	OUTPUT:
		RETVAL

int
SDLK_o ()
	CODE:
		RETVAL = SDLK_o;
	OUTPUT:
		RETVAL

int
SDLK_p ()
	CODE:
		RETVAL = SDLK_p;
	OUTPUT:
		RETVAL

int
SDLK_q ()
	CODE:
		RETVAL = SDLK_q;
	OUTPUT:
		RETVAL

int
SDLK_r ()
	CODE:
		RETVAL = SDLK_r;
	OUTPUT:
		RETVAL

int
SDLK_s ()
	CODE:
		RETVAL = SDLK_s;
	OUTPUT:
		RETVAL

int
SDLK_t ()
	CODE:
		RETVAL = SDLK_t;
	OUTPUT:
		RETVAL

int
SDLK_u ()
	CODE:
		RETVAL = SDLK_u;
	OUTPUT:
		RETVAL

int
SDLK_v ()
	CODE:
		RETVAL = SDLK_v;
	OUTPUT:
		RETVAL

int
SDLK_w ()
	CODE:
		RETVAL = SDLK_w;
	OUTPUT:
		RETVAL

int
SDLK_x ()
	CODE:
		RETVAL = SDLK_x;
	OUTPUT:
		RETVAL

int
SDLK_y ()
	CODE:
		RETVAL = SDLK_y;
	OUTPUT:
		RETVAL

int
SDLK_z ()
	CODE:
		RETVAL = SDLK_z;
	OUTPUT:
		RETVAL

int
SDLK_DELETE ()
	CODE:
		RETVAL = SDLK_DELETE;
	OUTPUT:
		RETVAL

int
SDLK_KP0 ()
	CODE:
		RETVAL = SDLK_KP0;
	OUTPUT:
		RETVAL

int
SDLK_KP1 ()
	CODE:
		RETVAL = SDLK_KP1;
	OUTPUT:
		RETVAL

int
SDLK_KP2 ()
	CODE:
		RETVAL = SDLK_KP2;
	OUTPUT:
		RETVAL

int
SDLK_KP3 ()
	CODE:
		RETVAL = SDLK_KP3;
	OUTPUT:
		RETVAL

int
SDLK_KP4 ()
	CODE:
		RETVAL = SDLK_KP4;
	OUTPUT:
		RETVAL

int
SDLK_KP5 ()
	CODE:
		RETVAL = SDLK_KP5;
	OUTPUT:
		RETVAL

int
SDLK_KP6 ()
	CODE:
		RETVAL = SDLK_KP6;
	OUTPUT:
		RETVAL

int
SDLK_KP7 ()
	CODE:
		RETVAL = SDLK_KP7;
	OUTPUT:
		RETVAL

int
SDLK_KP8 ()
	CODE:
		RETVAL = SDLK_KP8;
	OUTPUT:
		RETVAL

int
SDLK_KP9 ()
	CODE:
		RETVAL = SDLK_KP9;
	OUTPUT:
		RETVAL

int
SDLK_KP_PERIOD ()
	CODE:
		RETVAL = SDLK_KP_PERIOD;
	OUTPUT:
		RETVAL

int
SDLK_KP_DIVIDE ()
	CODE:
		RETVAL = SDLK_KP_DIVIDE;
	OUTPUT:
		RETVAL

int
SDLK_KP_MULTIPLY ()
	CODE:
		RETVAL = SDLK_KP_MULTIPLY;
	OUTPUT:
		RETVAL

int
SDLK_KP_MINUS ()
	CODE:
		RETVAL = SDLK_KP_MINUS;
	OUTPUT:
		RETVAL

int
SDLK_KP_PLUS ()
	CODE:
		RETVAL = SDLK_KP_PLUS;
	OUTPUT:
		RETVAL

int
SDLK_KP_ENTER ()
	CODE:
		RETVAL = SDLK_KP_ENTER;
	OUTPUT:
		RETVAL

int
SDLK_KP_EQUALS ()
	CODE:
		RETVAL = SDLK_KP_EQUALS;
	OUTPUT:
		RETVAL

int
SDLK_UP ()
	CODE:
		RETVAL = SDLK_UP;
	OUTPUT:
		RETVAL

int
SDLK_DOWN ()
	CODE:
		RETVAL = SDLK_DOWN;
	OUTPUT:
		RETVAL

int
SDLK_RIGHT ()
	CODE:
		RETVAL = SDLK_RIGHT;
	OUTPUT:
		RETVAL

int
SDLK_LEFT ()
	CODE:
		RETVAL = SDLK_LEFT;
	OUTPUT:
		RETVAL

int
SDLK_INSERT ()
	CODE:
		RETVAL = SDLK_INSERT;
	OUTPUT:
		RETVAL

int
SDLK_HOME ()
	CODE:
		RETVAL = SDLK_HOME;
	OUTPUT:
		RETVAL

int
SDLK_END ()
	CODE:
		RETVAL = SDLK_END;
	OUTPUT:
		RETVAL

int
SDLK_PAGEUP ()
	CODE:
		RETVAL = SDLK_PAGEUP;
	OUTPUT:
		RETVAL

int
SDLK_PAGEDOWN ()
	CODE:
		RETVAL = SDLK_PAGEDOWN;
	OUTPUT:
		RETVAL

int
SDLK_F1 ()
	CODE:
		RETVAL = SDLK_F1;
	OUTPUT:
		RETVAL

int
SDLK_F2 ()
	CODE:
		RETVAL = SDLK_F2;
	OUTPUT:
		RETVAL

int
SDLK_F3 ()
	CODE:
		RETVAL = SDLK_F3;
	OUTPUT:
		RETVAL

int
SDLK_F4 ()
	CODE:
		RETVAL = SDLK_F4;
	OUTPUT:
		RETVAL

int
SDLK_F5 ()
	CODE:
		RETVAL = SDLK_F5;
	OUTPUT:
		RETVAL

int
SDLK_F6 ()
	CODE:
		RETVAL = SDLK_F6;
	OUTPUT:
		RETVAL

int
SDLK_F7 ()
	CODE:
		RETVAL = SDLK_F7;
	OUTPUT:
		RETVAL

int
SDLK_F8 ()
	CODE:
		RETVAL = SDLK_F8;
	OUTPUT:
		RETVAL

int
SDLK_F9 ()
	CODE:
		RETVAL = SDLK_F9;
	OUTPUT:
		RETVAL

int
SDLK_F10 ()
	CODE:
		RETVAL = SDLK_F10;
	OUTPUT:
		RETVAL

int
SDLK_F11 ()
	CODE:
		RETVAL = SDLK_F11;
	OUTPUT:
		RETVAL

int
SDLK_F12 ()
	CODE:
		RETVAL = SDLK_F12;
	OUTPUT:
		RETVAL

int
SDLK_F13 ()
	CODE:
		RETVAL = SDLK_F13;
	OUTPUT:
		RETVAL

int
SDLK_F14 ()
	CODE:
		RETVAL = SDLK_F14;
	OUTPUT:
		RETVAL

int
SDLK_F15 ()
	CODE:
		RETVAL = SDLK_F15;
	OUTPUT:
		RETVAL

int
SDLK_NUMLOCK ()
	CODE:
		RETVAL = SDLK_NUMLOCK;
	OUTPUT:
		RETVAL

int
SDLK_CAPSLOCK ()
	CODE:
		RETVAL = SDLK_CAPSLOCK;
	OUTPUT:
		RETVAL

int
SDLK_SCROLLOCK ()
	CODE:
		RETVAL = SDLK_SCROLLOCK;
	OUTPUT:
		RETVAL

int
SDLK_RSHIFT ()
	CODE:
		RETVAL = SDLK_RSHIFT;
	OUTPUT:
		RETVAL

int
SDLK_LSHIFT ()
	CODE:
		RETVAL = SDLK_LSHIFT;
	OUTPUT:
		RETVAL

int
SDLK_RCTRL ()
	CODE:
		RETVAL = SDLK_RCTRL;
	OUTPUT:
		RETVAL

int
SDLK_LCTRL ()
	CODE:
		RETVAL = SDLK_LCTRL;
	OUTPUT:
		RETVAL

int
SDLK_RALT ()
	CODE:
		RETVAL = SDLK_RALT;
	OUTPUT:
		RETVAL

int
SDLK_LALT ()
	CODE:
		RETVAL = SDLK_LALT;
	OUTPUT:
		RETVAL

int
SDLK_RMETA ()
	CODE:
		RETVAL = SDLK_RMETA;
	OUTPUT:
		RETVAL

int
SDLK_LMETA ()
	CODE:
		RETVAL = SDLK_LMETA;
	OUTPUT:
		RETVAL

int
SDLK_LSUPER ()
	CODE:
		RETVAL = SDLK_LSUPER;
	OUTPUT:
		RETVAL

int
SDLK_RSUPER ()
	CODE:
		RETVAL = SDLK_RSUPER;
	OUTPUT:
		RETVAL

int
SDLK_MODE ()
	CODE:
		RETVAL = SDLK_MODE;
	OUTPUT:
		RETVAL

int
SDLK_HELP ()
	CODE:
		RETVAL = SDLK_HELP;
	OUTPUT:
		RETVAL

int
SDLK_PRINT ()
	CODE:
		RETVAL = SDLK_PRINT;
	OUTPUT:
		RETVAL

int
SDLK_SYSREQ ()
	CODE:
		RETVAL = SDLK_SYSREQ;
	OUTPUT:
		RETVAL

int
SDLK_BREAK ()
	CODE:
		RETVAL = SDLK_BREAK;
	OUTPUT:
		RETVAL

int
SDLK_MENU ()
	CODE:
		RETVAL = SDLK_MENU;
	OUTPUT:
		RETVAL

int
SDLK_POWER ()
	CODE:
		RETVAL = SDLK_POWER;
	OUTPUT:
		RETVAL

int
SDLK_EURO ()
	CODE:
		RETVAL = SDLK_EURO;
	OUTPUT:
		RETVAL


int
KMOD_NONE ()
	CODE:
		RETVAL = KMOD_NONE;
	OUTPUT:
		RETVAL

int
KMOD_NUM ()
	CODE:
		RETVAL = KMOD_NUM;
	OUTPUT:
		RETVAL

int
KMOD_CAPS ()
	CODE:
		RETVAL = KMOD_CAPS;
	OUTPUT:
		RETVAL

int
KMOD_LCTRL ()
	CODE:
		RETVAL = KMOD_LCTRL;
	OUTPUT:
		RETVAL

int
KMOD_RCTRL ()
	CODE:
		RETVAL = KMOD_RCTRL;
	OUTPUT:
		RETVAL

int
KMOD_RSHIFT ()
	CODE:
		RETVAL = KMOD_RSHIFT;
	OUTPUT:
		RETVAL

int
KMOD_LSHIFT ()
	CODE:
		RETVAL = KMOD_LSHIFT;
	OUTPUT:
		RETVAL

int
KMOD_RALT ()
	CODE:
		RETVAL = KMOD_RALT;
	OUTPUT:
		RETVAL

int
KMOD_LALT ()
	CODE:
		RETVAL = KMOD_LALT;
	OUTPUT:
		RETVAL

int
KMOD_CTRL ()
	CODE:
		RETVAL = KMOD_CTRL;
	OUTPUT:
		RETVAL

int
KMOD_SHIFT ()
	CODE:
		RETVAL = KMOD_SHIFT;
	OUTPUT:
		RETVAL

int
KMOD_ALT ()
	CODE:
		RETVAL = KMOD_ALT;
	OUTPUT:
		RETVAL

int
KeyEventSym ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->key.keysym.sym;
	OUTPUT:
		RETVAL

int 
KeyEventMod ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->key.keysym.mod;
	OUTPUT:
		RETVAL

Uint16
KeyEventUnicode ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->key.keysym.unicode;
	OUTPUT:
		RETVAL

Uint8
KeyEventScanCode ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->key.keysym.scancode;
	OUTPUT:
		RETVAL

Uint8
MouseMotionState ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->motion.state;
	OUTPUT:	
		RETVAL

Uint16
MouseMotionX ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->motion.x;
	OUTPUT:
		RETVAL

Uint16
MouseMotionY ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->motion.y;
	OUTPUT:
		RETVAL

Sint16
MouseMotionXrel( e )
	SDL_Event *e
	CODE:
		RETVAL = e->motion.xrel;
	OUTPUT:
		RETVAL

Sint16
MouseMotionYrel ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->motion.yrel;
	OUTPUT:
		RETVAL

Uint8
MouseButtonState ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->button.state;
	OUTPUT:
		RETVAL

Uint8
MouseButton ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->button.button;
	OUTPUT:
		RETVAL

Uint16
MouseButtonX ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->button.x;
	OUTPUT:
		RETVAL

Uint16
MouseButtonY ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->button.y;
	OUTPUT:
		RETVAL

SDL_SysWMmsg *
SysWMEventMsg ( e )
	SDL_Event *e
	CODE:
		RETVAL = e->syswm.msg;
	OUTPUT:
		RETVAL

int
EnableUnicode ( enable )
	int enable
	CODE:
		RETVAL = SDL_EnableUNICODE(enable);
	OUTPUT:
		RETVAL

void
EnableKeyRepeat ( delay, interval )
	int delay
	int interval
	CODE:
		SDL_EnableKeyRepeat(delay,interval);

char *
GetKeyName ( sym )
	int sym
	CODE:
		RETVAL = SDL_GetKeyName(sym);
	OUTPUT:
		RETVAL

Uint8
PRESSED ()
	CODE:
		RETVAL = SDL_PRESSED;
	OUTPUT:
		RETVAL

Uint8
RELEASED ()
	CODE:
		RETVAL = SDL_RELEASED;
	OUTPUT:
		RETVAL

SDL_Surface *
CreateRGBSurface (flags, width, height, depth, Rmask, Gmask, Bmask, Amask )
	Uint32 flags
	int width
	int height
	int depth
	Uint32 Rmask
	Uint32 Gmask
	Uint32 Bmask
	Uint32 Amask
	CODE:
		RETVAL = SDL_CreateRGBSurface ( flags, width, height,
				depth, Rmask, Gmask, Bmask, Amask );
	OUTPUT:	
		RETVAL


SDL_Surface *
CreateRGBSurfaceFrom (pixels, width, height, depth, pitch, Rmask, Gmask, Bmask, Amask )
	void *pixels
	int width
	int height
	int depth
	int pitch
	Uint32 Rmask
	Uint32 Gmask
	Uint32 Bmask
	Uint32 Amask
	CODE:
		RETVAL = SDL_CreateRGBSurfaceFrom ( pixels, width, height,
				depth, pitch, Rmask, Gmask, Bmask, Amask );
	OUTPUT:	
		RETVAL

#ifdef HAVE_SDL_IMAGE

SDL_Surface *
IMGLoad ( fname )
	char *fname
	CODE:
		RETVAL = IMG_Load(fname);
	OUTPUT:
		RETVAL

#endif

void
FreeSurface ( surface )
	SDL_Surface *surface
	CODE:
		SDL_FreeSurface(surface);
	
Uint32
SurfaceFlags ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->flags;
	OUTPUT:
		RETVAL

SDL_Palette *
SurfacePalette ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->palette;
	OUTPUT:
		RETVAL

Uint8
SurfaceBitsPerPixel ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->BitsPerPixel;
	OUTPUT:
		RETVAL

Uint8
SurfaceBytesPerPixel ( surface )
	SDL_Surface *surface
	CODE:	
		RETVAL = surface->format->BytesPerPixel;
	OUTPUT:
		RETVAL

Uint8
SurfaceRshift ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->Rshift;
	OUTPUT:
		RETVAL

Uint8
SurfaceGshift ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->Gshift;
	OUTPUT:
		RETVAL

Uint8
SurfaceBshift ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->Bshift;
	OUTPUT:
		RETVAL

Uint8
SurfaceAshift ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->Ashift;
	OUTPUT:
		RETVAL

Uint32
SurfaceRmask( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->Rmask;
	OUTPUT:
		RETVAL

Uint32
SurfaceGmask ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->Gmask;
	OUTPUT:
		RETVAL

Uint32
SurfaceBmask ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->Bmask;
	OUTPUT:
		RETVAL

Uint32
SurfaceAmask ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->Amask;
	OUTPUT:
		RETVAL

Uint32
SurfaceColorKey ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->colorkey;
	OUTPUT:
		RETVAL

Uint32
SurfaceAlpha( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = surface->format->alpha;
	OUTPUT:
		RETVAL

int
SurfaceW ( surface )
	SDL_Surface *surface
	CODE:	
		RETVAL = surface->w;
	OUTPUT:
		RETVAL

int
SurfaceH ( surface )
	SDL_Surface *surface
	CODE:	
		RETVAL = surface->h;
	OUTPUT:
		RETVAL

Uint16
SurfacePitch ( surface )
	SDL_Surface *surface
	CODE:	
		RETVAL = surface->pitch;
	OUTPUT:
		RETVAL

void *
SurfacePixels ( surface )
	SDL_Surface *surface
	CODE:	
		RETVAL = surface->pixels;
	OUTPUT:
		RETVAL

Uint32
SurfacePixel ( surface, x, y, ... )
	SDL_Surface *surface
	Sint32 x
	Sint32 y
	CODE:
		Uint32 pixel;
		Uint8 *bitbucket, bpp;
		bpp = surface->format->BytesPerPixel;
		bitbucket = ((Uint8 *)surface->pixels)+y*surface->pitch+x*bpp;
		if ( items > 3 ) {
			pixel = SvIV(ST(3));
			switch(bpp) {
				case 1:
					*((Uint8 *)(bitbucket)) = (Uint8)pixel;
					break;
				case 2:
					*((Uint16 *)(bitbucket)) = 
						(Uint16)pixel;
					break;
				case 3: {
					Uint8 r,g,b;
					r = 
					(pixel>>surface->format->Rshift)*0xff;
					g = 
					(pixel>>surface->format->Gshift)*0xff;
					b = 
					(pixel>>surface->format->Bshift)*0xff;
					*((bitbucket)+
						surface->format->Rshift/8) = r;
					*((bitbucket)+
						surface->format->Gshift/8) = g;
					*((bitbucket)+
						surface->format->Bshift/8) = b;
					}
					break;
				case 4:
					*((Uint32 *)(bitbucket)) = 
						(Uint32)pixel;
					break;
			}
		}
		switch ( bpp ) {
			case 1:
				RETVAL = (Uint32)*((Uint8 *)(bitbucket));
				break;
			case 2:
				RETVAL = (Uint32)*((Uint16 *)(bitbucket));
				break;
			case 3:
				{ Uint8 r,g,b;
					r = *((bitbucket) + 
						surface->format->Rshift/8);
					g = *((bitbucket) + 
						surface->format->Gshift/8);
					b = *((bitbucket) + 
						surface->format->Bshift/8);
					RETVAL = (Uint32)
						 (r<<surface->format->Rshift) +
						 (g<<surface->format->Gshift) +
						 (b<<surface->format->Bshift);
				} break;
			case 4:
				RETVAL = (Uint32)*((Uint32 *)(bitbucket));
				break;
		}
	OUTPUT:
		RETVAL

int
MUSTLOCK ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = SDL_MUSTLOCK(surface);
	OUTPUT:
		RETVAL		

int
SurfaceLock ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = SDL_LockSurface(surface);
	OUTPUT:
		RETVAL

void
SurfaceUnlock ( surface )
	SDL_Surface *surface
	CODE:
		SDL_UnlockSurface(surface);

SDL_Surface *
GetVideoSurface ()
	CODE:
		RETVAL = SDL_GetVideoSurface();
	OUTPUT:
		RETVAL


HV *
VideoInfo ()
	CODE:
		HV *hv;
		SDL_VideoInfo *info;
		info = (SDL_VideoInfo *) safemalloc ( sizeof(SDL_VideoInfo));
		memcpy(info,SDL_GetVideoInfo(),sizeof(SDL_VideoInfo));
		hv = newHV();
		hv_store(hv,"hw_available",strlen("hw_available"),
			newSViv(info->hw_available),0);
		hv_store(hv,"wm_available",strlen("wm_available"),
			newSViv(info->wm_available),0);
		hv_store(hv,"blit_hw",strlen("blit_hw"),
			newSViv(info->blit_hw),0);
		hv_store(hv,"blit_hw_CC",strlen("blit_hw_CC"),
			newSViv(info->blit_hw_CC),0);
		hv_store(hv,"blit_hw_A",strlen("blit_hw_A"),
			newSViv(info->blit_hw_A),0);
		hv_store(hv,"blit_sw",strlen("blit_sw"),
			newSViv(info->blit_sw),0);
		hv_store(hv,"blit_sw_CC",strlen("blit_sw_CC"),
			newSViv(info->blit_sw_CC),0);
		hv_store(hv,"blit_sw_A",strlen("blit_sw_A"),
			newSViv(info->blit_sw_A),0);
		hv_store(hv,"blit_fill",strlen("blit_fill"),
			newSViv(info->blit_fill),0);
		hv_store(hv,"video_mem",strlen("video_mem"),
			newSViv(info->video_mem),0);
		RETVAL = hv;
	OUTPUT:
		RETVAL

SDL_Rect *
NewRect ( x, y, w, h )
	Sint16 x
	Sint16 y
	Uint16 w
	Uint16 h
	CODE:
		RETVAL = (SDL_Rect *) safemalloc (sizeof(SDL_Rect));
		RETVAL->x = x;
		RETVAL->y = y;
		RETVAL->w = w;
		RETVAL->h = h;
	OUTPUT:
		RETVAL

void
FreeRect ( rect )
	SDL_Rect *rect
	CODE:
		safefree(rect);

Sint16
RectX ( rect, ... )
	SDL_Rect *rect
	CODE:
		if (items > 1 ) rect->x = SvIV(ST(1)); 
		RETVAL = rect->x;
	OUTPUT:
		RETVAL

Sint16
RectY ( rect, ... )
	SDL_Rect *rect
	CODE:
		if (items > 1 ) rect->y = SvIV(ST(1)); 
		RETVAL = rect->y;
	OUTPUT:
		RETVAL

Uint16
RectW ( rect, ... )
	SDL_Rect *rect
	CODE:
		if (items > 1 ) rect->w = SvIV(ST(1)); 
		RETVAL = rect->w;
	OUTPUT:
		RETVAL

Uint16
RectH ( rect, ... )
	SDL_Rect *rect
	CODE:
		if (items > 1 ) rect->h = SvIV(ST(1)); 
		RETVAL = rect->h;
	OUTPUT:
		RETVAL

SDL_Color *
NewColor ( r, g, b )
	Uint8 r
	Uint8 g
	Uint8 b
	CODE:
		RETVAL = (SDL_Color *) safemalloc(sizeof(SDL_Color));
		RETVAL->r = r;
		RETVAL->g = g;
		RETVAL->b = b;
	OUTPUT:
		RETVAL

Uint8
ColorR ( color, ... )
	SDL_Color *color
	CODE:
		if (items > 1 ) color->r = SvIV(ST(1)); 
		RETVAL = color->r;
	OUTPUT:
		RETVAL

Uint8
ColorG ( color, ... )
	SDL_Color *color
	CODE:
		if (items > 1 ) color->g = SvIV(ST(1)); 
		RETVAL = color->g;
	OUTPUT:
		RETVAL

Uint8
CologB ( color, ... )
	SDL_Color *color
	CODE:
		if (items > 1 ) color->b = SvIV(ST(1)); 
		RETVAL = color->b;
	OUTPUT:
		RETVAL

void
FreeColor ( color )
	SDL_Color *color
	CODE:
		safefree(color);

SDL_Palette *
NewPalette ( number )
	int number
	CODE:
		RETVAL = (SDL_Palette *)safemalloc(sizeof(SDL_Palette));
		RETVAL->colors = (SDL_Color *)safemalloc(number * 
						sizeof(SDL_Color));
		RETVAL->ncolors = number;
	OUTPUT:
		RETVAL

int
PaletteNColors ( palette, ... )
	SDL_Palette *palette
	CODE:
		if ( items > 1 ) palette->ncolors = SvIV(ST(1));
		RETVAL = palette->ncolors;
	OUTPUT:
		RETVAL

SDL_Color *
PaletteColors ( palette, index, ... )
	SDL_Palette *palette
	int index
	CODE:
		if ( items > 2 ) {
			palette->colors[index].r = SvUV(ST(2)); 
			palette->colors[index].g = SvUV(ST(3)); 
			palette->colors[index].b = SvUV(ST(4)); 
		}
		RETVAL = (SDL_Color *)(palette->colors + index);
	OUTPUT:
		RETVAL

Uint32
SWSURFACE ()
	CODE:
		RETVAL = SDL_SWSURFACE;
	OUTPUT:
		RETVAL

Uint32
HWSURFACE ()
	CODE:
		RETVAL = SDL_HWSURFACE;
	OUTPUT:
		RETVAL

Uint32
ANYFORMAT ()
	CODE:
		RETVAL = SDL_ANYFORMAT;
	OUTPUT:
		RETVAL

Uint32
HWPALETTE ()
	CODE:
		RETVAL = SDL_HWPALETTE;
	OUTPUT:
		RETVAL

Uint32
DOUBLEBUF ()
	CODE:
		RETVAL = SDL_DOUBLEBUF;
	OUTPUT:
		RETVAL

Uint32
FULLSCREEN ()
	CODE:
		RETVAL = SDL_FULLSCREEN;
	OUTPUT:
		RETVAL


Uint32
ASYNCBLIT ()
	CODE:
		RETVAL = SDL_ASYNCBLIT;
	OUTPUT:
		RETVAL


Uint32
OPENGL ()
	CODE:
		RETVAL = SDL_OPENGL;
	OUTPUT:
		RETVAL

Uint32
HWACCEL ()
	CODE:
		RETVAL = SDL_HWACCEL;
	OUTPUT:
		RETVAL

Uint32
RESIZABLE ()
	CODE:
		RETVAL = SDL_RESIZABLE;
	OUTPUT:
		RETVAL

int
VideoModeOK ( width, height, bpp, flags )
	int width
	int height
	int bpp
	Uint32 flags
	CODE:
		RETVAL = SDL_VideoModeOK(width,height,bpp,flags);
	OUTPUT:
		RETVAL

SDL_Surface *
SetVideoMode ( width, height, bpp, flags )
	int width
	int height
	int bpp
	Uint32 flags
	CODE:
		RETVAL = SDL_SetVideoMode(width,height,bpp,flags);
	OUTPUT:
		RETVAL

void
UpdateRects ( surface, ... )
	SDL_Surface *surface
	CODE:
		SDL_Rect *rects, *temp;
		int num_rects,i;
		if ( items < 2 ) return;
		num_rects = items - 1;	
		rects = (SDL_Rect *)safemalloc(sizeof(SDL_Rect)*items);
		for(i=0;i<num_rects;i++) {
			temp = (SDL_Rect *)SvIV(ST(i+1));
			rects[i].x = temp->x;
			rects[i].y = temp->y;
			rects[i].w = temp->w;
			rects[i].h = temp->h;
		} 
		SDL_UpdateRects(surface,num_rects,rects);
		safefree(rects);

int
Flip ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = SDL_Flip(surface);
	OUTPUT:
		RETVAL

int
SetColors ( surface, start, ... )
	SDL_Surface *surface
	int start
	CODE:
		SDL_Color *colors,*temp;
		int i, length;
		if ( items < 3 ) { RETVAL = 0;	goto all_done; }
		length = items - 2;
		colors = (SDL_Color *)safemalloc(sizeof(SDL_Color)*(length+1));
		for ( i = 0; i < length ; i++ ) {
			temp = (SDL_Color *)SvIV(ST(i+2));
			colors[i].r = temp->r;
			colors[i].g = temp->g;
			colors[i].b = temp->b;
		}
		RETVAL = SDL_SetColors(surface, colors, start, length );
		safefree(colors);
all_done:
	OUTPUT:	
		RETVAL

Uint32
MapRGB ( surface, r, g, b )
	SDL_Surface *surface
	Uint8 r
	Uint8 g
	Uint8 b
	CODE:
		RETVAL = SDL_MapRGB(surface->format,r,g,b);
	OUTPUT:
		RETVAL

Uint32
MapRGBA ( surface, r, g, b, a )
	SDL_Surface *surface
	Uint8 r
	Uint8 g
	Uint8 b
	Uint8 a
	CODE:
		RETVAL = SDL_MapRGBA(surface->format,r,g,b,a);
	OUTPUT:
		RETVAL

AV *
GetRGB ( surface, pixel )
	SDL_Surface *surface
	Uint32 pixel
	CODE:
		Uint8 r,g,b;
		SDL_GetRGB(pixel,surface->format,&r,&g,&b);
		RETVAL = newAV();
		av_push(RETVAL,newSViv(r));
		av_push(RETVAL,newSViv(g));
		av_push(RETVAL,newSViv(b));
	OUTPUT:
		RETVAL

AV *
GetRGBA ( surface, pixel )
	SDL_Surface *surface
	Uint32 pixel
	CODE:
		Uint8 r,g,b,a;
		SDL_GetRGBA(pixel,surface->format,&r,&g,&b,&a);
		RETVAL = newAV();
		av_push(RETVAL,newSViv(r));
		av_push(RETVAL,newSViv(g));
		av_push(RETVAL,newSViv(b));
		av_push(RETVAL,newSViv(a));
	OUTPUT:
		RETVAL

int
SaveBMP ( surface, filename )
	SDL_Surface *surface
	char *filename
	CODE:
		RETVAL = SDL_SaveBMP(surface,filename);
	OUTPUT:
		RETVAL	

int
SetColorKey ( surface, flag, key )
	SDL_Surface *surface
	Uint32 flag
	Uint32 key
	CODE:
		RETVAL = SDL_SetColorKey(surface,flag,key);
	OUTPUT:
		RETVAL

Uint32
SRCCOLORKEY ()
	CODE:
		RETVAL = SDL_SRCCOLORKEY;
	OUTPUT:	
		RETVAL

Uint32
RLEACCEL ()
	CODE:
		RETVAL = SDL_RLEACCEL;
	OUTPUT:
		RETVAL

Uint32
RLEACCELOK ()
	CODE:
		RETVAL = SDL_RLEACCELOK;
	OUTPUT:
		RETVAL

Uint32
SRCALPHA ()
	CODE:
		RETVAL = SDL_SRCALPHA;
	OUTPUT:
		RETVAL

int
SetAlpha ( surface, flag, alpha )
	SDL_Surface *surface
	Uint32 flag
	Uint8 alpha
	CODE:
		RETVAL = SDL_SetAlpha(surface,flag,alpha);
	OUTPUT:
		RETVAL

SDL_Surface *
DisplayFormat ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = SDL_DisplayFormat(surface);
	OUTPUT:
		RETVAL

int
BlitSurface ( src, src_rect, dest, dest_rect )
	SDL_Surface *src
	SDL_Rect *src_rect
	SDL_Surface *dest
	SDL_Rect *dest_rect
	CODE:
		RETVAL = SDL_BlitSurface(src,src_rect,dest,dest_rect);
	OUTPUT:
		RETVAL

int
FillRect ( dest, dest_rect, color )
	SDL_Surface *dest
	SDL_Rect *dest_rect
	Uint32 color
	CODE:
		RETVAL = SDL_FillRect(dest,dest_rect,color);
	OUTPUT:
		RETVAL

void
WMSetCaption ( title, icon )
	char *title
	char *icon
	CODE:
		SDL_WM_SetCaption(title,icon);

AV *
WMGetCaption ()
	CODE:
		char *title,*icon;
		SDL_WM_GetCaption(&title,&icon);
		RETVAL = newAV();
		av_push(RETVAL,newSVpv(title,0));
		av_push(RETVAL,newSVpv(icon,0));
	OUTPUT:
		RETVAL

void
WMSetIcon ( icon )
	SDL_Surface *icon
	CODE:
		SDL_WM_SetIcon(icon,NULL);

void
WarpMouse ( x, y )
	Uint16 x
	Uint16 y
	CODE:
		SDL_WarpMouse(x,y);

SDL_Cursor *
NewCursor ( data, mask, x ,y )
	SDL_Surface *data
	SDL_Surface *mask
	int x
	int y
	CODE:
		RETVAL = SDL_CreateCursor((Uint8*)data->pixels,
				(Uint8*)mask->pixels,data->w,data->h,x,y);
	OUTPUT:
		RETVAL

void
FreeCursor ( cursor )
	SDL_Cursor *cursor
	CODE:
		SDL_FreeCursor(cursor);

void
SetCursor ( cursor )
	SDL_Cursor *cursor
	CODE:
		SDL_SetCursor(cursor);

SDL_Cursor *
GetCursor ()
	CODE:
		RETVAL = SDL_GetCursor();
	OUTPUT:
		RETVAL

int
ShowCursor ( toggle )
	int toggle
	CODE:
		RETVAL = SDL_ShowCursor(toggle);
	OUTPUT: 
		RETVAL

SDL_AudioSpec *
NewAudioSpec ( freq, format, channels, samples, callback, userdata )
	int freq
	Uint16 format
	Uint8 channels
	Uint16 samples
	void *callback
	void *userdata
	CODE:
		RETVAL = (SDL_AudioSpec *)safemalloc(sizeof(SDL_AudioSpec));
		RETVAL->freq = freq;
		RETVAL->channels = channels;
		RETVAL->samples = samples;
		RETVAL->callback = callback;
		RETVAL->userdata = userdata;
	OUTPUT:
		RETVAL

void
FreeAudioSpec ( spec )
	SDL_AudioSpec *spec
	CODE:
		safefree(spec);

Uint16
AUDIO_U8 ()
	CODE:
		RETVAL = AUDIO_U8;
	OUTPUT: 
		RETVAL

Uint16
AUDIO_S8 ()
	CODE:
		RETVAL = AUDIO_S8;
	OUTPUT: 
		RETVAL

Uint16
AUDIO_U16 ()
	CODE:
		RETVAL = AUDIO_U16;
	OUTPUT: 
		RETVAL

Uint16
AUDIO_S16 ()
	CODE:
		RETVAL = AUDIO_S16;
	OUTPUT: 
		RETVAL

Uint16
AUDIO_U16MSB ()
	CODE:
		RETVAL = AUDIO_U16MSB;
	OUTPUT: 
		RETVAL

Uint16
AUDIO_S16MSB ()
	CODE:
		RETVAL = AUDIO_S16MSB;
	OUTPUT: 
		RETVAL

SDL_AudioCVT *
NewAudioCVT ( src_format, src_channels, src_rate, dst_format, dst_channels, dst_rate)
	Uint16 src_format
	Uint8 src_channels
	int src_rate
	Uint16 dst_format
	Uint8 dst_channels
	int dst_rate
	CODE:
		RETVAL = (SDL_AudioCVT *)safemalloc(sizeof(SDL_AudioCVT));
		if (SDL_BuildAudioCVT(RETVAL,src_format, src_channels, src_rate,
			dst_format, dst_channels, dst_rate)) { 
			safefree(RETVAL); RETVAL = NULL; }
	OUTPUT:
		RETVAL

void
FreeAudioCVT ( cvt )
	SDL_AudioCVT *cvt
	CODE:
		safefree(cvt);

int
ConvertAudioData ( cvt, data, len )
	SDL_AudioCVT *cvt
	Uint8 *data
	int len
	CODE:
		cvt->len = len;
		cvt->buf = (Uint8*) safemalloc(cvt->len*cvt->len_mult);
		memcpy(cvt->buf,data,cvt->len);
		RETVAL = SDL_ConvertAudio(cvt);
	OUTPUT:
		RETVAL			

int
OpenAudio ( spec )
	SDL_AudioSpec *spec
	CODE:
		RETVAL = SDL_OpenAudio(spec,NULL);
	OUTPUT:
		RETVAL

void
PauseAudio ( p_on )
	int p_on
	CODE:
		SDL_PauseAudio(p_on);
	
void
LockAudio ()
	CODE:
		SDL_LockAudio();

void
UnlockAudio ()
	CODE:
		SDL_UnlockAudio();

void
CloseAudio ()
	CODE:
		SDL_CloseAudio();

void
FreeWAV ( buf )
	Uint8 *buf
	CODE:
		SDL_FreeWAV(buf);

AV *
LoadWAV ( filename, spec )
	char *filename
	SDL_AudioSpec *spec
	CODE:
		SDL_AudioSpec *temp;
		Uint8 *buf;
		Uint32 len;

		RETVAL = newAV();
		temp = SDL_LoadWAV(filename,spec,&buf,&len);
		if ( ! temp ) goto error;
		av_push(RETVAL,newSViv((Uint32)temp));
		av_push(RETVAL,newSViv((Uint32)buf));
		av_push(RETVAL,newSViv(len));
error:
	OUTPUT:
		RETVAL

void
MixAudio ( dst, src, len, volume )
	Uint8 *dst
	Uint8 *src
	Uint32 len
	int volume
	CODE:
		SDL_MixAudio(dst,src,len,volume);

#ifdef HAVE_SDL_MIXER
	
int
MIX_MAX_VOLUME ()
	CODE:
		RETVAL = MIX_MAX_VOLUME;
	OUTPUT:
		RETVAL

int
MIX_DEFAULT_FREQUENCY ()
	CODE:
		RETVAL = MIX_DEFAULT_FREQUENCY;
	OUTPUT:
		RETVAL

Uint16
MIX_DEFAULT_FORMAT ()
	CODE:
		RETVAL = MIX_DEFAULT_FORMAT;
	OUTPUT:	
		RETVAL

int
MIX_DEFAULT_CHANNELS ()
	CODE:
		RETVAL = MIX_DEFAULT_CHANNELS;
	OUTPUT:
		RETVAL

Mix_Fading
MIX_NO_FADING ()
	CODE:
		RETVAL = MIX_NO_FADING;
	OUTPUT:	
		RETVAL

Mix_Fading
MIX_FADING_OUT ()
	CODE:
		RETVAL = MIX_FADING_OUT;
	OUTPUT:
		RETVAL

Mix_Fading
MIX_FADING_IN ()
	CODE:
		RETVAL = MIX_FADING_IN;
	OUTPUT:
		RETVAL

int
MixOpenAudio ( frequency, format, channels, chunksize )
	int frequency
	Uint16 format
	int channels
	int chunksize	
	CODE:
		RETVAL = Mix_OpenAudio(frequency, format, channels, chunksize);
	OUTPUT:
		RETVAL

int
MixAllocateChannels ( number )
	int number
	CODE:
		RETVAL = Mix_AllocateChannels(number);
	OUTPUT:
		RETVAL

AV *
MixQuerySpec ()
	CODE:
		int freq, channels, status;
		Uint16 format;
		status = Mix_QuerySpec(&freq,&format,&channels);
		RETVAL = newAV();
		av_push(RETVAL,newSViv(status));
		av_push(RETVAL,newSViv(freq));
		av_push(RETVAL,newSViv(format));
		av_push(RETVAL,newSViv(channels));
	OUTPUT:
		RETVAL

Mix_Chunk *
MixLoadWAV ( filename )
	char *filename
	CODE:
		RETVAL = Mix_LoadWAV(filename);
	OUTPUT:
		RETVAL

Mix_Music *
MixLoadMusic ( filename )
	char *filename
	CODE:
		RETVAL = Mix_LoadMUS(filename);
	OUTPUT:
		RETVAL

Mix_Chunk *
MixQuickLoadWAV ( buf )
	Uint8 *buf
	CODE:
		RETVAL = Mix_QuickLoad_WAV(buf);
	OUTPUT:
		RETVAL

void
MixFreeChunk( chunk )
	Mix_Chunk *chunk
	CODE:
		Mix_FreeChunk(chunk);

void
MixFreeMusic ( music )
	Mix_Music *music
	CODE:
		Mix_FreeMusic(music);

void
MixSetPostMixCallback ( func, arg )
	void *func
	void *arg
	CODE:
		Mix_SetPostMix(func,arg);

void
MixSetMusicHook ( func, arg )
	void *func
	void *arg
	CODE:
		Mix_HookMusic(func,arg);

void
MixSetMusicFinishedHook ( func )
	void *func
	CODE:
		Mix_HookMusicFinished(func);

void *
MixGetMusicHookData ()
	CODE:
		RETVAL = Mix_GetMusicHookData();
	OUTPUT:
		RETVAL

int
MixReverseChannels ( number )
	int number
	CODE:
		RETVAL = Mix_ReserveChannels ( number );
	OUTPUT:
		RETVAL

int
MixGroupChannel ( which, tag )
	int which
	int tag
	CODE:
		RETVAL = Mix_GroupChannel(which,tag);
	OUTPUT:
		RETVAL

int
MixGroupChannels ( from, to, tag )
	int from
	int to
	int tag
	CODE:
		RETVAL = Mix_GroupChannels(from,to,tag);
	OUTPUT:
		RETVAL

int
MixGroupAvailable ( tag )
	int tag
	CODE:
		RETVAL = Mix_GroupAvailable(tag);
	OUTPUT:
		RETVAL

int
MixGroupCount ( tag )
	int tag
	CODE:
		RETVAL = Mix_GroupCount(tag);
	OUTPUT:
		RETVAL

int
MixGroupOldest ( tag )
	int tag
	CODE:
		RETVAL = Mix_GroupOldest(tag);
	OUTPUT:
		RETVAL

int
MixGroupNewer ( tag )
	int tag
	CODE:
		RETVAL = Mix_GroupNewer(tag);
	OUTPUT:
		RETVAL

int
MixPlayChannel ( channel, chunk, loops )
	int channel
	Mix_Chunk *chunk
	int loops
	CODE:
		RETVAL = Mix_PlayChannel(channel,chunk,loops);
	OUTPUT:
		RETVAL

int
MixPlayChannelTimed ( channel, chunk, loops, ticks )
	int channel
	Mix_Chunk *chunk
	int loops
	int ticks
	CODE:
		RETVAL = Mix_PlayChannelTimed(channel,chunk,loops,ticks);
	OUTPUT:
		RETVAL

int
MixPlayMusic ( music, loops )
	Mix_Music *music
	int loops
	CODE:
		RETVAL = Mix_PlayMusic(music,loops);
	OUTPUT:
		RETVAL

int
MixFadeInChannel ( channel, chunk, loops, ms )
	int channel
	Mix_Chunk *chunk
	int loops
	int ms
	CODE:
		RETVAL = Mix_FadeInChannel(channel,chunk,loops,ms);
	OUTPUT:
		RETVAL

int
MixFadeInChannelTimed ( channel, chunk, loops, ms, ticks )
	int channel
	Mix_Chunk *chunk
	int loops
	int ticks
	int ms
	CODE:
		RETVAL = Mix_FadeInChannelTimed(channel,chunk,loops,ms,ticks);
	OUTPUT:
		RETVAL

int
MixFadeInMusic ( music, loops, ms )
	Mix_Music *music
	int loops
	int ms
	CODE:
		RETVAL = Mix_FadeInMusic(music,loops,ms);
	OUTPUT:
		RETVAL

int
MixVolume ( channel, volume )
	int channel
	int volume
	CODE:	
		RETVAL = Mix_Volume(channel,volume);
	OUTPUT:
		RETVAL

int
MixVolumeChunk ( chunk, volume )
	Mix_Chunk *chunk
	int volume
	CODE:
		RETVAL = Mix_VolumeChunk(chunk,volume);
	OUTPUT:
		RETVAL

int
MixVolumeMusic ( volume )
	int volume
	CODE:
		RETVAL = Mix_VolumeMusic(volume);
	OUTPUT:
		RETVAL

int
MixHaltChannel ( channel )
	int channel
	CODE:
		RETVAL = Mix_HaltChannel(channel);
	OUTPUT:
		RETVAL

int
MixHaltGroup ( tag )
	int tag
	CODE:
		RETVAL = Mix_HaltGroup(tag);
	OUTPUT:
		RETVAL

int
MixHaltMusic ()
	CODE:
		RETVAL = Mix_HaltMusic();
	OUTPUT:
		RETVAL

int
MixExpireChannel ( channel, ticks )
	int channel
	int ticks
	CODE:
		RETVAL = Mix_ExpireChannel ( channel,ticks);
	OUTPUT:
		RETVAL

int
MixFadeOutChannel ( which, ms )
	int which
	int ms
	CODE:
		RETVAL = Mix_FadeOutChannel(which,ms);
	OUTPUT:
		RETVAL

int
MixFadeOutGroup ( which, ms )
	int which
	int ms
	CODE:
		RETVAL = Mix_FadeOutGroup(which,ms);
	OUTPUT:
		RETVAL

int
MixFadeOutMusic ( ms )
	int ms
	CODE:
		RETVAL = Mix_FadeOutMusic(ms);
	OUTPUT:
		RETVAL

Mix_Fading
MixFadingMusic()
	CODE:
		RETVAL = Mix_FadingMusic();
	OUTPUT:
		RETVAL

Mix_Fading
MixFadingChannel( which )
	int which
	CODE:
		RETVAL = Mix_FadingChannel(which);
	OUTPUT:
		RETVAL

void
MixPause ( channel )
	int channel
	CODE:
		Mix_Pause(channel);

void
MixResume ( channel )
	int channel
	CODE:
		Mix_Resume(channel);

int
MixPaused ( channel )
	int channel
	CODE:
		RETVAL = Mix_Paused(channel);
	OUTPUT:
		RETVAL

void
MixPauseMusic ()
	CODE:
		Mix_PauseMusic();

void
MixResumeMusic ()
	CODE:
		Mix_ResumeMusic();

void
MixRewindMusic ()
	CODE:
		Mix_RewindMusic();

int
MixPausedMusic ()
	CODE:
		RETVAL = Mix_PausedMusic();
	OUTPUT:
		RETVAL

int
MixPlaying( channel )
	int channel	
	CODE:
		RETVAL = Mix_Playing(channel);
	OUTPUT:
		RETVAL

int
MixPlayingMusic()
	CODE:
		RETVAL = Mix_PlayingMusic();
	OUTPUT:
		RETVAL


void
MixCloseAudio ()
	CODE:
		Mix_CloseAudio();

#endif

#ifdef HAVE_SDL_IMAGE

SDL_Surface *
NewFont ( filename )
	char *filename
	CODE:
		RETVAL = IMG_Load(filename);
		InitFont(RETVAL);
	OUTPUT:
		RETVAL

void
UseFont ( surface )
	SDL_Surface *surface
	CODE:
		InitFont(surface);

void
PutString ( surface, x, y, text )
	SDL_Surface *surface
	int x
	int y
	char *text
	CODE:
		PutString( surface, x, y, text );

int
TextWidth ( text )
	char *text
	CODE:
		RETVAL = TextWidth(text);
	OUTPUT:
		RETVAL
		
#endif

Uint32
GL_RED_SIZE ()
	CODE:
		RETVAL = SDL_GL_RED_SIZE;
	OUTPUT:
		RETVAL

Uint32
GL_GREEN_SIZE ()
	CODE:
		RETVAL = SDL_GL_GREEN_SIZE;
	OUTPUT:
		RETVAL

Uint32
GL_BLUE_SIZE ()
	CODE:
		RETVAL = SDL_GL_BLUE_SIZE;
	OUTPUT:
		RETVAL


Uint32
GL_ALPHA_SIZE ()
	CODE:
		RETVAL = SDL_GL_ALPHA_SIZE;
	OUTPUT:
		RETVAL


Uint32
GL_ACCUM_RED_SIZE ()
	CODE:
		RETVAL = SDL_GL_ACCUM_RED_SIZE;
	OUTPUT:
		RETVAL


Uint32
GL_ACCUM_GREEN_SIZE ()
	CODE:
		RETVAL = SDL_GL_ACCUM_GREEN_SIZE;
	OUTPUT:
		RETVAL

Uint32
GL_ACCUM_BLUE_SIZE ()
	CODE:
		RETVAL = SDL_GL_ACCUM_BLUE_SIZE;
	OUTPUT:
		RETVAL


Uint32
GL_ACCUM_ALPHA_SIZE ()
	CODE:
		RETVAL = SDL_GL_ACCUM_ALPHA_SIZE;
	OUTPUT:
		RETVAL



Uint32
GL_BUFFER_SIZE ()
	CODE:
		RETVAL = SDL_GL_BUFFER_SIZE;
	OUTPUT:
		RETVAL

Uint32
GL_DEPTH_SIZE ()
	CODE:
		RETVAL = SDL_GL_DEPTH_SIZE;
	OUTPUT:
		RETVAL


Uint32
GL_STENCIL_SIZE ()
	CODE:
		RETVAL = SDL_GL_STENCIL_SIZE;
	OUTPUT:
		RETVAL


Uint32
GL_DOUBLEBUFFER ()
	CODE:
		RETVAL = SDL_GL_DOUBLEBUFFER;
	OUTPUT:
		RETVAL


int
GL_SetAttribute ( attr,  value )
	int        attr
	int        value
	CODE:
		RETVAL = SDL_GL_SetAttribute(attr, value);
	OUTPUT:
	        RETVAL

int
GL_GetAttribute ( attr,  value )
	int        attr
	int        *value
	CODE:
		RETVAL = SDL_GL_GetAttribute(attr, value);
	OUTPUT:
	        RETVAL


void
GL_SwapBuffers ()
	CODE:
		SDL_GL_SwapBuffers ();


int
BigEndian ()
	CODE:
		RETVAL = (SDL_BYTEORDER == SDL_BIG_ENDIAN);
	OUTPUT:
		RETVAL

int
NumJoysticks ()
	CODE:
		RETVAL = SDL_NumJoysticks();
	OUTPUT:
		RETVAL

const char *
JoystickName ( index )
	int index
	CODE:
		RETVAL = SDL_JoystickName(index);
	OUTPUT:
		RETVAL

SDL_Joystick *
JoystickOpen ( index ) 
	int index
	CODE:
		RETVAL = SDL_JoystickOpen(index);
	OUTPUT:
		RETVAL

int
JoystickOpened ( index )
	int index
	CODE:
		RETVAL = SDL_JoystickOpened(index);
	OUTPUT:
		RETVAL

int
JoystickIndex ( joystick )
	SDL_Joystick *joystick
	CODE:
		RETVAL = SDL_JoystickIndex(joystick);
	OUTPUT:
		RETVAL

int
JoystickNumAxes ( joystick )
	SDL_Joystick *joystick
	CODE:
		RETVAL = SDL_JoystickNumAxes(joystick);
	OUTPUT:
		RETVAL

int
JoystickNumBalls ( joystick )
	SDL_Joystick *joystick
	CODE:
		RETVAL = SDL_JoystickNumBalls(joystick);
	OUTPUT:
		RETVAL

int
JoystickNumHats ( joystick )
	SDL_Joystick *joystick
	CODE:
		RETVAL = SDL_JoystickNumHats(joystick);
	OUTPUT:
		RETVAL

int
JoystickNumButtons ( joystick )
	SDL_Joystick *joystick
	CODE:
		RETVAL = SDL_JoystickNumButtons(joystick);
	OUTPUT:
		RETVAL

void
JoystickUpdate ()
	CODE:
		SDL_JoystickUpdate();

Sint16
JoystickGetAxis ( joystick, axis )
	SDL_Joystick *joystick
	int axis
	CODE:
		RETVAL = SDL_JoystickGetAxis(joystick,axis);
	OUTPUT:
		RETVAL

Uint8
JoystickGetHat ( joystick, hat )
	SDL_Joystick *joystick
	int hat 
	CODE:
		RETVAL = SDL_JoystickGetHat(joystick,hat);
	OUTPUT:
		RETVAL

Uint8
JoystickGetButton ( joystick, button)
	SDL_Joystick *joystick
	int button 
	CODE:
		RETVAL = SDL_JoystickGetButton(joystick,button);
	OUTPUT:
		RETVAL

AV *
JoystickGetBall ( joystick, ball )
	SDL_Joystick *joystick
	int ball 
	CODE:
		int success,dx,dy;
		success = SDL_JoystickGetBall(joystick,ball,&dx,&dy);
		RETVAL = newAV();
		av_push(RETVAL,newSViv(success));
		av_push(RETVAL,newSViv(dx));
		av_push(RETVAL,newSViv(dy));
	OUTPUT:
		RETVAL	

void
JoystickClose ( joystick )
	SDL_Joystick *joystick
	CODE:
		SDL_JoystickClose(joystick);

void
SetClipRect ( surface, rect )
	SDL_Surface *surface
	SDL_Rect *rect
	CODE:
		SDL_SetClipRect(surface,rect);
	
SDL_Rect*
GetClipRect ( surface )
	SDL_Surface *surface
	CODE:
		RETVAL = (SDL_Rect*) safemalloc(sizeof(SDL_Rect));
		SDL_GetClipRect(surface,RETVAL);
	OUTPUT:
		RETVAL


#ifdef HAVE_SDL_NET

int
NetInit ()
	CODE:
		RETVAL = SDLNet_Init();
	OUTPUT:
		RETVAL

void
NetQuit ()
	CODE:
		SDLNet_Quit();

IPaddress*
NetNewIPaddress ( host, port )
	Uint32 host
	Uint16 port
	CODE:
		RETVAL = (IPaddress*) safemalloc(sizeof(IPaddress));
	OUTPUT:
		RETVAL

Uint32
NetIPaddressHost ( ip )
	IPaddress *ip
	CODE:
		RETVAL = ip->host;
	OUTPUT:
		RETVAL

Uint16
NetIPaddressPort ( ip )
	IPaddress *ip
	CODE:
		RETVAL = ip->port;
	OUTPUT:
		RETVAL

void
NetFreeIPaddress ( ip )
	IPaddress *ip
	CODE:
		safefree(ip);

Uint32
INADDR_ANY ()
	CODE:
		RETVAL = INADDR_ANY;
	OUTPUT:
		RETVAL

Uint32
INADDR_NONE ()
	CODE:
		RETVAL = INADDR_NONE;
	OUTPUT:
		RETVAL

char*
NetResolveIP ( address )
	IPaddress *address
	CODE:
		RETVAL = SDLNet_ResolveIP(address);
	OUTPUT:
		RETVAL

int
NetResolveHost ( address, host, port )
	IPaddress *address
	char *host
	Uint16 port
	CODE:
		RETVAL = SDLNet_ResolveHost(address,host,port);
	OUTPUT:
		RETVAL
	
TCPsocket
NetTCPOpen ( ip )
	IPaddress *ip
	CODE:
		RETVAL = SDLNet_TCP_Open(ip);
	OUTPUT:
		RETVAL

TCPsocket
NetTCPAccept ( server )
	TCPsocket server
	CODE:
		RETVAL = SDLNet_TCP_Accept(server);
	OUTPUT:
		RETVAL

IPaddress*
NetTCPGetPeerAddress ( sock )
	TCPsocket sock
	CODE:
		RETVAL = SDLNet_TCP_GetPeerAddress(sock);
	OUTPUT:
		RETVAL

int
NetTCPSend ( sock, data, len  )
	TCPsocket sock
	void *data
	int len
	CODE:
		RETVAL = SDLNet_TCP_Send(sock,data,len);
	OUTPUT:
		RETVAL

AV*
NetTCPRecv ( sock, maxlen )
	TCPsocket sock
	int maxlen
	CODE:
		int status;
		void *buffer;
		buffer = safemalloc(maxlen);
		RETVAL = newAV();
		status = SDLNet_TCP_Recv(sock,buffer,maxlen);
		av_push(RETVAL,newSViv(status));
		av_push(RETVAL,newSVpvn((char*)buffer,maxlen));
	OUTPUT:
		RETVAL	
	
void
NetTCPClose ( sock )
	TCPsocket sock
	CODE:
		SDLNet_TCP_Close(sock);

UDPpacket*
NetAllocPacket ( size )
	int size
	CODE:
		RETVAL = SDLNet_AllocPacket(size);
	OUTPUT:
		RETVAL

UDPpacket**
NetAllocPacketV ( howmany, size )
	int howmany
	int size
	CODE:
		RETVAL = SDLNet_AllocPacketV(howmany,size);
	OUTPUT:
		RETVAL

int
NetResizePacket ( packet, newsize )
	UDPpacket *packet
	int newsize
	CODE:
		RETVAL = SDLNet_ResizePacket(packet,newsize);
	OUTPUT:
		RETVAL

void
NetFreePacket ( packet )
	UDPpacket *packet
	CODE:
		SDLNet_FreePacket(packet);

void
NetFreePacketV ( packet )
	UDPpacket **packet
	CODE:
		SDLNet_FreePacketV(packet);

UDPsocket
NetUDPOpen ( port )
	Uint16 port
	CODE:
		RETVAL = SDLNet_UDP_Open(port);
	OUTPUT:
		RETVAL

int
NetUDPBind ( sock, channel, address )
	UDPsocket sock
	int channel
	IPaddress *address
	CODE:
		RETVAL = SDLNet_UDP_Bind(sock,channel,address);
	OUTPUT:
		RETVAL

void
NetUDPUnbind ( sock, channel )
	UDPsocket sock
	int channel
	CODE:
		SDLNet_UDP_Unbind(sock,channel);

IPaddress*
NetUDPGetPeerAddress ( sock, channel )
	UDPsocket sock
	int channel
	CODE:
		RETVAL = SDLNet_UDP_GetPeerAddress(sock,channel);
	OUTPUT:
		RETVAL

int
NetUDPSendV ( sock, packets, npackets )
	UDPsocket sock
	UDPpacket **packets
	int npackets
	CODE:
		RETVAL = SDLNet_UDP_SendV(sock,packets,npackets);
	OUTPUT:
		RETVAL

int
NetUDPSend ( sock, channel, packet )
	UDPsocket sock
	int channel
	UDPpacket *packet 
	CODE:
		RETVAL = SDLNet_UDP_Send(sock,channel,packet);
	OUTPUT:
		RETVAL

int
NetUDPRecvV ( sock, packets )
	UDPsocket sock
	UDPpacket **packets
	CODE:
		RETVAL = SDLNet_UDP_RecvV(sock,packets);
	OUTPUT:
		RETVAL

int
NetUDPRecv ( sock, packet )
	UDPsocket sock
	UDPpacket *packet
	CODE:
		RETVAL = SDLNet_UDP_Recv(sock,packet);
	OUTPUT:
		RETVAL

void
NetUDPClose ( sock )
	UDPsocket sock
	CODE:
		SDLNet_UDP_Close(sock);

SDLNet_SocketSet
NetAllocSocketSet ( maxsockets )
	int maxsockets
	CODE:
		RETVAL = SDLNet_AllocSocketSet(maxsockets);
	OUTPUT:
		RETVAL

int
NetTCP_AddSocket ( set, sock )
	SDLNet_SocketSet set
	TCPsocket sock
	CODE:
		RETVAL = SDLNet_TCP_AddSocket(set,sock);
	OUTPUT:
		RETVAL

int
NetUDP_AddSocket ( set, sock )
	SDLNet_SocketSet set
	UDPsocket sock
	CODE:
		RETVAL = SDLNet_UDP_AddSocket(set,sock);
	OUTPUT:
		RETVAL

int
NetTCP_DelSocket ( set, sock )
	SDLNet_SocketSet set
	TCPsocket sock
	CODE:
		RETVAL = SDLNet_TCP_DelSocket(set,sock);
	OUTPUT:
		RETVAL

int
NetUDP_DelSocket ( set, sock )
	SDLNet_SocketSet set
	UDPsocket sock
	CODE:
		RETVAL = SDLNet_UDP_DelSocket(set,sock);
	OUTPUT:
		RETVAL

int
NetCheckSockets ( set, timeout )
	SDLNet_SocketSet set
	Uint32 timeout
	CODE:
		RETVAL = SDLNet_CheckSockets(set,timeout);
	OUTPUT:
		RETVAL

int
NetSocketReady ( sock )
	SDLNet_GenericSocket sock
	CODE:
		RETVAL = SDLNet_SocketReady(sock);
	OUTPUT:
		RETVAL

void
NetFreeSocketSet ( set )
	SDLNet_SocketSet set
	CODE:
		SDLNet_FreeSocketSet(set);

void
NetWrite16 ( value, area )
	Uint16 value
	void *area
	CODE:
		SDLNet_Write16(value,area);

void
NetWrite32 ( value, area )
	Uint32 value
	void *area
	CODE:
		SDLNet_Write32(value,area);
	
Uint16
NetRead16 ( area )
	void *area
	CODE:
		RETVAL = SDLNet_Read16(area);
	OUTPUT:
		RETVAL

Uint32
NetRead32 ( area )
	void *area
	CODE:
		RETVAL = SDLNet_Read32(area);
	OUTPUT:
		RETVAL

#endif 

#ifdef HAVE_SDL_TTF

int
TTFInit ()
	CODE:
		RETVAL = TTF_Init();
	OUTPUT:
		RETVAL

void
TTFQuit ()
	CODE:
		TTF_Quit();

TTF_Font*
TTFOpenFont ( file, ptsize )
	const char *file
	int ptsize
	CODE:
		RETVAL = TTF_OpenFont(file,ptsize);
	OUTPUT:
		RETVAL

int
TTF_STYLE_NORMAL ()
	CODE:
		RETVAL = TTF_STYLE_NORMAL;
	OUTPUT:
		RETVAL

int
TTF_STYLE_BOLD ()
	CODE:
		RETVAL = TTF_STYLE_BOLD;
	OUTPUT:
		RETVAL

int
TTF_STYLE_ITALIC ()
	CODE:
		RETVAL = TTF_STYLE_ITALIC;
	OUTPUT:
		RETVAL

int
TTF_STYLE_UNDERLINE ()
	CODE:
		RETVAL = TTF_STYLE_UNDERLINE;
	OUTPUT:
		RETVAL

int
TTFGetFontStyle ( font )
	TTF_Font *font
	CODE:
		RETVAL = TTF_GetFontStyle(font);
	OUTPUT:
		RETVAL

void
TTFSetFontStyle ( font, style )
	TTF_Font *font
	int style
	CODE:
		TTF_SetFontStyle(font,style);
	
int
TTFFontHeight ( font )
	TTF_Font *font
	CODE:
		RETVAL = TTF_FontHeight(font);
	OUTPUT:
		RETVAL

int
TTFFontAscent ( font )
	TTF_Font *font
	CODE:
		RETVAL = TTF_FontAscent(font);
	OUTPUT:
		RETVAL

int
TTFFontDescent ( font )
	TTF_Font *font
	CODE:
		RETVAL = TTF_FontDescent(font);
	OUTPUT:
		RETVAL

int
TTFFontLineSkip ( font )
	TTF_Font *font
	CODE:
		RETVAL = TTF_FontLineSkip(font);
	OUTPUT:
		RETVAL

AV*
TTFGlyphMetrics ( font, ch )
	TTF_Font *font
	Uint16 ch
	CODE:
		int minx, miny, maxx, maxy, advance;
		RETVAL = newAV();
		TTF_GlyphMetrics(font, ch, &minx, &miny, &maxx, &maxy, &advance);
		av_push(RETVAL,newSViv(minx));
		av_push(RETVAL,newSViv(miny));
		av_push(RETVAL,newSViv(maxx));
		av_push(RETVAL,newSViv(maxy));
		av_push(RETVAL,newSViv(advance));
	OUTPUT:
		RETVAL

AV*
TTFSizeText ( font, text )
	TTF_Font *font
	const char *text
	CODE:
		int w,h;
		RETVAL = newAV();
		TTF_SizeText(font,text,&w,&h);
		av_push(RETVAL,newSViv(w));
		av_push(RETVAL,newSViv(h));
	OUTPUT:
		RETVAL

AV*
TTFSizeUTF8 ( font, text )
	TTF_Font *font
	const char *text
	CODE:
		int w,h;
		RETVAL = newAV();
		TTF_SizeUTF8(font,text,&w,&h);
		av_push(RETVAL,newSViv(w));
		av_push(RETVAL,newSViv(h));
	OUTPUT:
		RETVAL

AV*
TTFSizeUNICODE ( font, text )
	TTF_Font *font
	const Uint16 *text
	CODE:
		int w,h;
		RETVAL = newAV();
		TTF_SizeUNICODE(font,text,&w,&h);
		av_push(RETVAL,newSViv(w));
		av_push(RETVAL,newSViv(h));
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderTextSolid ( font, text, fg )
	TTF_Font *font
	const char *text
	SDL_Color *fg
	CODE:
		RETVAL = TTF_RenderText_Solid(font,text,*fg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderUTF8Solid ( font, text, fg )
	TTF_Font *font
	const char *text
	SDL_Color *fg
	CODE:
		RETVAL = TTF_RenderUTF8_Solid(font,text,*fg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderUNICODESolid ( font, text, fg )
	TTF_Font *font
	const Uint16 *text
	SDL_Color *fg
	CODE:
		RETVAL = TTF_RenderUNICODE_Solid(font,text,*fg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderGlyphSolid ( font, ch, fg )
	TTF_Font *font
	Uint16 ch
	SDL_Color *fg
	CODE:
		RETVAL = TTF_RenderGlyph_Solid(font,ch,*fg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderTextShaded ( font, text, fg, bg )
	TTF_Font *font
	const char *text
	SDL_Color *fg
	SDL_Color *bg
	CODE:
		RETVAL = TTF_RenderText_Shaded(font,text,*fg,*bg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderUTF8Shaded( font, text, fg, bg )
	TTF_Font *font
	const char *text
	SDL_Color *fg
	SDL_Color *bg
	CODE:
		RETVAL = TTF_RenderUTF8_Shaded(font,text,*fg,*bg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderUNICODEShaded( font, text, fg, bg )
	TTF_Font *font
	const Uint16 *text
	SDL_Color *fg
	SDL_Color *bg
	CODE:
		RETVAL = TTF_RenderUNICODE_Shaded(font,text,*fg,*bg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderGlyphShaded ( font, ch, fg, bg )
	TTF_Font *font
	Uint16 ch
	SDL_Color *fg
	SDL_Color *bg
	CODE:
		RETVAL = TTF_RenderGlyph_Shaded(font,ch,*fg,*bg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderTextBlended( font, text, fg )
	TTF_Font *font
	const char *text
	SDL_Color *fg
	CODE:
		RETVAL = TTF_RenderText_Blended(font,text,*fg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderUTF8Blended( font, text, fg )
	TTF_Font *font
	const char *text
	SDL_Color *fg
	CODE:
		RETVAL = TTF_RenderUTF8_Blended(font,text,*fg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderUNICODEBlended( font, text, fg )
	TTF_Font *font
	const Uint16 *text
	SDL_Color *fg
	CODE:
		RETVAL = TTF_RenderUNICODE_Blended(font,text,*fg);
	OUTPUT:
		RETVAL

SDL_Surface*
TTFRenderGlyphBlended( font, ch, fg )
	TTF_Font *font
	Uint16 ch
	SDL_Color *fg
	CODE:
		RETVAL = TTF_RenderGlyph_Blended(font,ch,*fg);
	OUTPUT:
		RETVAL

void
TTFCloseFont ( font )
	TTF_Font *font
	CODE:
		TTF_CloseFont(font);

int
TTFPutString ( font, surface, x, y, fg, bg, text )
	TTF_Font *font
	SDL_Surface *surface
	int x
	int y
	SDL_Color *fg
	SDL_Color *bg
	const char *text
	CODE:
		SDL_Surface *img;
		SDL_Rect dest;
		int w,h;
		dest.x = x;
		dest.y = y;
		TTF_SizeText(font,text,&w,&h);
		dest.w = w;
		dest.h = h;
		img = TTF_RenderText_Shaded(font,text,*fg,*bg);
		RETVAL = -1;
		if ( img && img->format && img->format->palette ) {
			SDL_Color *c = &img->format->palette->colors[0];
			Uint32 key = SDL_MapRBG( img->format, c->r, c->g, c->b );
			SDL_SetColorKey(img,SDL_SRCCOLORKEY,key );
			RETVAL = SDL_BlitSurface(surface,&dest,img,&dest);	
			SDL_FreeSurface(img);
		}
	OUTPUT:
		RETVAL

#endif

	
