// SDL::OpenGL
//
// Copyright (C) 2002,2003,2004 David J. Goehrig

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifndef aTHX_
#define aTHX_
#endif

#include <SDL.h>

#include <gl.h>
#include <glu.h>

#ifdef USE_THREADS
#define HAVE_TLS_CONTEXT
#endif

#ifndef GL_ALL_CLIENT_ATTRIB_BITS  
#define GL_ALL_CLIENT_ATTRIB_BITS 0xFFFFFFF
#endif /* GL_ALL_CLIENT_BITS */  

#include "../defines.h"

SV* sdl_perl_nurbs_error_hook;
void
sdl_perl_nurbs_error_callback ( GLenum errorCode )
{
	ENTER_TLS_CONTEXT
	dSP;

	ENTER;
	SAVETMPS;
	PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSViv(errorCode)));
	PUTBACK;

	call_sv(sdl_perl_nurbs_error_hook,G_VOID);
	
	FREETMPS;
	LEAVE;
	LEAVE_TLS_CONTEXT	
}

void
sdl_perl_nurbs_being_callback ( GLenum type, void *cb )
{
	SV *cmd;
	ENTER_TLS_CONTEXT
	dSP;

	cmd = (SV*)cb;

	ENTER;
	SAVETMPS;
	PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSViv(type)));
	PUTBACK;

	call_sv(cmd,G_VOID);
	
	FREETMPS;
	LEAVE;
	LEAVE_TLS_CONTEXT	
}

void
sdl_perl_nurbs_multi_callback ( GLfloat *vec, void *cb )
{
	SV *cmd;
	ENTER_TLS_CONTEXT
	dSP;

	cmd = (SV*)cb;

	ENTER;
	SAVETMPS;
	PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSViv(PTR2IV(vec))));
	PUTBACK;

	call_sv(cmd,G_VOID);
	
	FREETMPS;
	LEAVE;
	LEAVE_TLS_CONTEXT	
}

void
sdl_perl_nurbs_end_callback ( void *cb )
{
	SV *cmd;
	ENTER_TLS_CONTEXT

	cmd = (SV*)cb;

	ENTER;
	SAVETMPS;

	call_sv(cmd,G_VOID);
	
	FREETMPS;
	LEAVE;
	LEAVE_TLS_CONTEXT	
}

void
sdl_perl_tess_end_callback ( void *cb )
{
	SV *cmd;
        ENTER_TLS_CONTEXT
	dSP;

        cmd = (SV*)cb;

        ENTER;
        SAVETMPS;
	PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSViv(GLU_TESS_BEGIN)));
	PUTBACK;

        call_sv(cmd,G_VOID);

        FREETMPS;
        LEAVE;
        LEAVE_TLS_CONTEXT
}

void
sdl_perl_tess_begin_callback ( GLenum type,  void *cb )
{
        SV *cmd;
        ENTER_TLS_CONTEXT
	dSP;

        cmd = (SV*)cb;

        ENTER;
        SAVETMPS;
	PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSViv(GLU_TESS_BEGIN)));
	XPUSHs(sv_2mortal(newSViv(type)));
	PUTBACK;

        call_sv(cmd,G_VOID);

        FREETMPS;
        LEAVE;
        LEAVE_TLS_CONTEXT
}

void
sdl_perl_tess_error_callback ( GLenum type,  void *cb )
{
        SV *cmd;
        ENTER_TLS_CONTEXT
	dSP;

        cmd = (SV*)cb;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
        XPUSHs(sv_2mortal(newSViv(GLU_TESS_ERROR)));
        XPUSHs(sv_2mortal(newSViv(type)));
        PUTBACK;

        call_sv(cmd,G_VOID);

        FREETMPS;
        LEAVE;
        LEAVE_TLS_CONTEXT
}

void
sdl_perl_tess_edge_flag_callback ( GLenum flag,  void *cb )
{
        SV *cmd;
        ENTER_TLS_CONTEXT
	dSP;

        cmd = (SV*)cb;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSViv(GLU_TESS_EDGE_FLAG)));
        XPUSHs(sv_2mortal(newSViv(flag)));
        PUTBACK;

        call_sv(cmd,G_VOID);

        FREETMPS;
        LEAVE;
        LEAVE_TLS_CONTEXT
}

void
sdl_perl_tess_vertex_callback ( double *vd,  void *cb )
{
        SV *cmd;
        ENTER_TLS_CONTEXT
	dSP;

        cmd = (SV*)cb;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSViv(GLU_TESS_VERTEX)));
        XPUSHs(sv_2mortal(newSVnv(vd[0])));
        XPUSHs(sv_2mortal(newSVnv(vd[1])));
        XPUSHs(sv_2mortal(newSVnv(vd[2])));
        XPUSHs(sv_2mortal(newSVnv(vd[3])));
        XPUSHs(sv_2mortal(newSVnv(vd[4])));
        XPUSHs(sv_2mortal(newSVnv(vd[5])));
        PUTBACK;

        call_sv(cmd,G_VOID);

        FREETMPS;
        LEAVE;
        LEAVE_TLS_CONTEXT
}

void
sdl_perl_tess_combine_callback ( GLdouble coords[3], double *vd[4], GLfloat weight[4], 
	GLdouble **out, void *cb )
{
        SV *cmd;
	double *data;
	int width;
        ENTER_TLS_CONTEXT
	dSP;

        cmd = (SV*)cb;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSViv(GLU_TESS_COMBINE)));
	XPUSHs(sv_2mortal(newSVpvn((char*)coords,sizeof(GLdouble)*3)));
	XPUSHs(sv_2mortal(newSVpvn((char*)vd,sizeof(GLdouble*)*4)));
	XPUSHs(sv_2mortal(newSVpvn((char*)weight,sizeof(GLfloat)*4)));
        PUTBACK;

        if ( 1 != call_sv(cmd,G_SCALAR) ) {
		Perl_croak(aTHX_ "sdl_perl_tess_combine_callback failed");
	}

	data = (double*)POPp;
	width = (int)POPi;
	*out = (double*)malloc(sizeof(double)*width);
	memcpy(*out,data,sizeof(double)*width);

        FREETMPS;
        LEAVE;
        LEAVE_TLS_CONTEXT
}

MODULE = SDL::OpenGL		PACKAGE = SDL::OpenGL
PROTOTYPES : DISABLE

#ifdef HAVE_GL

void
glClearColor ( r, g, b, a)
	double r
	double g
	double b
	double a
	CODE:
		glClearColor((GLfloat)r,(GLfloat)g,(GLfloat)b,(GLfloat)a);

void
glClearIndex ( index )
	double index
	CODE:
		glClearIndex(index);

void
glClearDepth ( depth )
	double depth
	CODE:
		glClearDepth(depth);

void
glClearStencil ( s )
	int s
	CODE:
		glClearStencil(s);

void
glClearAccum ( r, g, b, a )
	double r
	double g
	double b
	double a
	CODE:
		glClearAccum((GLfloat)r,(GLfloat)g,(GLfloat)b,(GLfloat)a);

void
glClear ( m )
	GLbitfield m
	CODE:
		glClear(m);

void
glFlush ()
	CODE:
		glFlush();

void
glFinish ()
	CODE:
		glFinish();

void
glRect ( r )
	SDL_Rect* r
	CODE:
		glRecti(r->x,r->y,r->x+r->w,r->y+r->h);

void
glVertex ( x, y, ... )
	double x
	double y
	CODE:
		double z,w;
		if ( items == 4 ) {
			w = SvNV(ST(3));
			z = SvNV(ST(2));
			glVertex4d(x,y,z,w);	
		} else if ( items == 3 ) {
			z = SvNV(ST(2));
			glVertex3d(x,y,z);	
		} else {
			glVertex2d(x,y);
		}
		
void
glBegin ( mode )
	GLenum mode
	CODE:
		glBegin(mode);

void
glEnd ()
	CODE:
		glEnd();

void
glEnable ( cap )
	GLenum cap
	CODE:
		glEnable(cap);

void
glDisable ( cap )
	GLenum cap
	CODE:
		glDisable(cap);

double
glGet ( param )
	GLenum param
	CODE:
		glGetDoublev(param,&RETVAL);
	OUTPUT:
		RETVAL

Uint32
glIsEnabled ( cap )
	Uint32 cap
	CODE:
		RETVAL = glIsEnabled(cap);
	OUTPUT:
		RETVAL

void
glPointSize ( size )
	double size
	CODE:
		glPointSize((GLfloat)size);

void
glLineWidth ( size )
	double size
	CODE:
		glLineWidth((GLfloat)size);

void
glLineStipple ( factor, pattern )
	Sint32 factor
	Uint16 pattern
	CODE:
		glLineStipple(factor,pattern);

void
glPolygonMode ( face, mode )
	GLenum face
	GLenum mode
	CODE:
		glPolygonMode(face,mode);

void
glFrontFace ( mode )
	GLenum mode
	CODE:
		glFrontFace(mode);

void
glCullFace ( mode )
	GLenum mode
	CODE:
		glCullFace(mode);

void
glPolygonStipple ( mask )
	char *mask
	CODE:
		glPolygonStipple(mask);

void
glEdgeFlag ( flag )
	GLenum flag
	CODE:
		glEdgeFlag(flag);

void
glNormal ( x, y, z )
	double x
	double y
	double z
	CODE:
		glNormal3d(x,y,z);

void
glEnableClientState ( array )
	GLenum array
	CODE:
		glEnableClientState(array);

void
glDisableClientState ( array )
	GLenum array
	CODE:
		glDisableClientState(array);

void
glVertexPointer ( size, type, stride, pointer)
	int size
	GLenum type
	Uint32 stride
	char *pointer
	CODE:
		glVertexPointer(size,type,stride,pointer);

void
glColorPointer ( size, type, stride, pointer )
	Sint32 size
	GLenum type
	Uint32 stride
	char *pointer
	CODE:
		glColorPointer(size,type,stride,pointer);

void
glNormalPointer ( type, stride, pointer )
	GLenum type
	Uint32 stride
	char *pointer
	CODE:
		glNormalPointer(type,stride,pointer);

void
glTexCoordPointer ( size, type, stride, pointer )
	Sint32 size
	GLenum type
	Uint32 stride
	char *pointer
	CODE:
		glTexCoordPointer(size,type,stride,pointer);

void
glEdgeFlagPointer ( stride, pointer )
	Uint32 stride
	char *pointer
	CODE:
		glEdgeFlagPointer(stride,pointer);

void
glArrayElement ( ith )
	Uint32 ith
	CODE:
		glArrayElement(ith);

void
glDrawElements ( mode, count, type, indices )
	GLenum mode
	Uint32 count
	GLenum type
	char *indices
	CODE:
		glDrawElements( mode, count, type, indices);

void
glDrawRangeElements ( mode, start, end, count, type, indices )
	GLenum mode
	Uint32 start
	Uint32 end
	Uint32 count
	GLenum type
	char *indices
	CODE:
		glDrawRangeElements(mode,start,end,count,type,indices);

void
glDrawArrays ( mode, first, count )
	GLenum mode
	Uint32 first
	Uint32 count
	CODE:
		glDrawArrays(mode,first,count);

void
glInterleavedArrays ( format, stride, pointer )
	GLenum format
	Uint32 stride
	char *pointer
	CODE:
		glInterleavedArrays(format,stride,pointer);

void
glPushAttrib ( mask )
	GLbitfield mask
	CODE:
		glPushAttrib(mask);

void
glPopAttrib ()
	CODE:
		glPopAttrib();

void
glPushClientAttrib ( mask )
	GLbitfield mask
	CODE:
		glPushClientAttrib(mask);

void
glPopClientAttrib ()
	CODE:
		glPopClientAttrib();

void
glMatrixMode ( mode )
	GLenum mode
	CODE:
		glMatrixMode(mode);

void
glLoadIdentity ()
	CODE:
		glLoadIdentity();

void
glLoadMatrix (  ... )
	CODE:
		int i;
		double mat[16];
		for ( i = 0; i < 16; i++ ) {
			mat[i] = (i < items  && SvNOK(ST(i)) ? SvNV(ST(i)) : 0.0 );
		}
		glLoadMatrixd(mat);

void
glMultMatrix ( ... )
	CODE:
		int i;
		double mat[16];
		for ( i = 0; i < 16; i++ ) {
			mat[i] = (i < items  && SvNOK(ST(i)) ? SvNV(ST(i)) : 0.0 );
		}
		glMultMatrixd(mat);

void
glTranslate ( x, y, z )
	double x
	double y
	double z
	CODE:
		glTranslated(x,y,z);

void
glRotate ( angle, x, y, z )
	double angle
	double x
	double y
	double z
	CODE:
		glRotated(angle,x,y,z);

void
glScale ( x, y, z )
	double x
	double y
	double z
	CODE:
		glScaled(x,y,z);

void
glFrustum ( left, right, bottom, top, n, f )
	double left
	double right
	double bottom
	double top
	double n
	double f
	CODE:
		glFrustum(left,right,bottom,top,n,f);

void
glOrtho ( left, right, bottom, top, n, f )
	double left
	double right
	double bottom
	double top
	double n
	double f
	CODE:
		glOrtho(left,right,bottom,top,n,f);

void
glViewport ( x, y, width, height )
	Sint32 x
	Sint32 y
	Uint32 width
	Uint32 height
	CODE:
		glViewport(x,y,width,height);

void
glDepthRange ( n, f )
	double n
	double f
	CODE:
		glDepthRange(n,f);

void
glPushMatrix ()
	CODE:
		glPushMatrix();

void
glPopMatrix ()
	CODE:
		glPopMatrix();

void
glClipPlane ( plane, ... )
	GLenum plane
	CODE:
		double v[4];
		int i;
		for (i = 0; i < 4; i++ ) {
			v[i] = (i+1 < items && SvNOK(ST(i+1))) ? SvNV(ST(i+1)) : 0.0;
		}
		glClipPlane(plane,v);
	
void
glColor ( r, g, b, ... )
	double r	
	double g
	double b	
	CODE:
		if ( items == 4 ) {
			double a;
			a = SvNV(ST(3));
			glColor4d(r,g,b,a);
		} else {
			glColor3d(r,g,b);	
		}

void
glIndex ( c )
	Uint32 c
	CODE:
		glIndexi(c);

void
glShadeModel ( mode )
	GLenum mode
	CODE:
		glShadeModel(mode);

void
glLight ( light, name, ... )
	GLenum light
	GLenum name
	CODE:
		int i;
		if ( items == 6 ) {
			float v[4];	
			for ( i = 0; i < 4; i++ ) {
				v[i] = (SvNOK(ST(i+2))) ? SvNV(ST(i+2)) : 0.0;
			}
			glLightfv(light,name,v);	
		} else if ( items == 5 ) {
			float v[3];
			for ( i = 0; i < 3; i++ ) {
				v[i] = (SvNOK(ST(i+2))) ? SvNV(ST(i+2)) : 0.0;
			}
			glLightfv(light,name,v);	
		} else if ( items == 3 ) {
			float v;
			v = SvNV(ST(2));
			glLightf(light,name,v);
		} else {
			Perl_croak(aTHX_ "SDL::OpenGL::Light invalid arguments");
		}

void 
glLightModel ( pname, ... )
	GLenum pname
	CODE:
		GLfloat vec[4];
		if ( pname == GL_LIGHT_MODEL_LOCAL_VIEWER ||
			pname == GL_LIGHT_MODEL_TWO_SIDE ||
			pname == GL_LIGHT_MODEL_COLOR_CONTROL ) {
			glLightModelf(pname,SvNV(ST(1)));
		} else if ( pname == GL_LIGHT_MODEL_AMBIENT) {
			vec[0] = SvNV(ST(1));
			vec[1] = SvNV(ST(2));
			vec[2] = SvNV(ST(3));
			vec[3] = SvNV(ST(4));
			glLightModelfv(pname,vec);
		}

void
glMaterial ( face, name, ... )
	GLenum face
	GLenum name
	CODE:
		int i;
		if ( items == 6 ) {
			float v[4];
			for ( i = 0; i < 4; i++ ) {
				v[i] = (SvNOK(ST(i+2))) ? SvNV(ST(i+2)) : 0.0;
			}
			glMaterialfv(face,name,v);
		} else if ( items == 5 ) {
			float v[3];
			for ( i = 0; i < 4; i++ ) {
				v[i] = (SvNOK(ST(i+2))) ? SvNV(ST(i+2)) : 0.0;
			}
			glMaterialfv(face,name,v);
		} else if ( items == 3 ) {	
			float v;
			v = SvNV(ST(2));
			glMaterialf(face,name,v);
		} else {
			Perl_croak(aTHX_ "SDL::OpenGL::Material invalid arguments");
		}

void
glColorMaterial ( face, mode )
	GLenum face
	GLenum mode
	CODE:
		glColorMaterial(face,mode);

void
glBlendFunc ( sfactor, dfactor )
	GLenum sfactor
	GLenum dfactor
	CODE:
		glBlendFunc(sfactor,dfactor);


void
glHint ( target, hint )
	GLenum target
	GLenum hint
	CODE:
		glHint(target,hint);	

void
glFog ( name, ... )
	GLenum name
	CODE:
		if ( items == 5 )  {
			float v[4];
			v[0] = SvNV(ST(1));	
			v[1] = SvNV(ST(2));	
			v[2] = SvNV(ST(3));	
			v[3] = SvNV(ST(4));	
			glFogfv(name,v);
		} else if ( items == 2 ) {
			float v;
			v = SvNV(ST(1));
			glFogf(name,v);
		} else {
			Perl_croak(aTHX_ "SDL::OpenGL::Material invalid arguments");
		}

void
glPolygonOffset ( factor, units )
	double factor
	double units
	CODE:
		glPolygonOffset(factor,units);

Uint32
glGenLists ( range )
	Uint32 range
	CODE:
		RETVAL = glGenLists(range);
	OUTPUT:
		RETVAL

void
glNewList ( list, mode )
	Uint32 list
	GLenum mode
	CODE:
		glNewList(list,mode);

void
glEndList ()
	CODE:
		glEndList();

void
glDeleteLists ( base, count )
        Uint32 base
        Uint32 count
        CODE:
                glDeleteLists(base, count);

void
glCallList ( list )
	Uint32 list
	CODE:
		glCallList(list);

Uint32
glIsList ( list )
	Uint32 list
	CODE:
		RETVAL = glIsList(list);
	OUTPUT:
		RETVAL

void
glListBase ( base )
	Uint32 base
	CODE:
		glListBase(base);

void
glCallLists ( ... )
	CODE:
		int *i, j;	
		if ( items > 0 ) {
			i = (int*)safemalloc(sizeof(int)* (items));
			for ( j = 0; j < items; j++ ) {
				i[j] = SvIV(ST(j));
			} 
		} else {
			Perl_croak(aTHX_ "usage: SDL::OpenGL::CallLists(type,...)");
		}
		glCallLists(items, GL_INT, i);
		safefree(i);

void
glCallListsString ( string )
	SV* string
	CODE:
		char *str;
		STRLEN len;
		str = SvPV(string,len);
		glCallLists(len,GL_BYTE,str);

void
glRasterPos ( x, y, z, ... )
	double x
	double y
	double z
	CODE:
		if ( items == 4 ) {
			double w = SvNV(ST(3));
			glRasterPos4d(x,y,z,w);
		} else {
			glRasterPos3d(x,y,z);
		}

void
glBitmap ( width, height, x1, y1, x2, y2, data )
	Uint32 width
	Uint32 height
	double x1
	double y1
	double x2
	double y2
	char *data
	CODE:
		glBitmap(width,height,x1,y1,x2,y2,data);

void
glDrawPixels ( width, height, format, type, pixels )
	Uint32 width
	Uint32 height
	GLenum format
	GLenum type
	char *pixels
	CODE:
		glDrawPixels(width,height,format,type,pixels);


SV*
ReadPixels ( x, y, width, height, format, type )
        Uint32 x
        Uint32 y
        Uint32 height
        Uint32 width
        GLenum format
        GLenum type
        CODE:
                int len, size;
                char *buf;
                                                                                                                                                            
                size = 1;       /* ALPHA, BLUE, GREEN or RED */
                if (format == GL_BGR || format == GL_RGB) {
                        size = 3;
                        }
                if (format == GL_BGRA || format == GL_RGBA) {
                        size = 4;
                        }
                len = height * width * size;            /* in bytes */
                RETVAL = newSV(len);                    /* alloc len+1 bytes */
                SvPOK_on(RETVAL);                       /* make an PV */
                buf = SvPVX(RETVAL);                    /* get ptr to buffer */
                                                                                                                                                            
                glReadPixels(x,y,width,height,format,type,buf);
                SvCUR_set(RETVAL, len);                 /* set real length */
        OUTPUT:
                RETVAL
                                                                                                                                                            
AV*
ReadPixel ( x, y )
        Uint32 x
        Uint32 y
        CODE:
                int rgba[4];    /* r,g,b,a */
                int i;
                                                                                                                                                            
                glReadPixels(x,y,1,1,GL_RGBA,GL_UNSIGNED_INT,rgba);
                RETVAL = newAV();
                for ( i = 0; i < 4; i++ ) {
                        av_push(RETVAL,newSViv(rgba[i]));
                }
        OUTPUT:
                RETVAL

void
glCopyPixels ( x, y, width, height, buffer )
	Sint32 x
	Sint32 y
	Uint32 width
	Uint32 height
	GLenum buffer
	CODE:
		glCopyPixels(x,y,width,height,buffer);

void
glPixelStore ( name, param )
	Sint32 name
	double param
	CODE:
		glPixelStorei(name,param);

void
glPixelTransfer ( name, ... )
	GLenum name
	CODE:
		switch ( name ) {
			case GL_MAP_COLOR:
			case GL_MAP_STENCIL:
			case GL_INDEX_SHIFT:
			case GL_INDEX_OFFSET:
				glPixelTransferi(name,SvIV(ST(1)));
				break;
			default:
				glPixelTransferf(name,SvNV(ST(1)));
				break;
		}

void
glPixelMap ( type, map, mapsize, values )
	GLenum type
	GLenum map
	Sint32 mapsize
	char *values
	CODE:
		switch (type) {
			case GL_UNSIGNED_INT: 
				glPixelMapuiv(map,mapsize,(GLint*)values);
				break;
			case GL_UNSIGNED_SHORT:
				glPixelMapusv(map,mapsize,(GLushort*)values);
				break;
			case GL_FLOAT:
				glPixelMapfv(map,mapsize,(GLfloat*)values);
				break;
		}
		
void
glPixelZoom ( zoomx, zoomy )
	double zoomx
	double zoomy
	CODE:
		glPixelZoom(zoomx,zoomy);

void
glColorTable ( target, internalFormat, width, format, type, data )
	GLenum target 
	GLenum internalFormat
	Uint32 width
	GLenum format
	GLenum type
	char *data
	CODE:
		glColorTable(target,internalFormat,width,format,type,data);

void
glColorTableParameter ( target, name, r, g, b, a)
	GLenum target
	GLenum name
	double r
	double g
	double b
	double a
	CODE:
		GLfloat vec[4];
		vec[0] = r;
		vec[1] = g;
		vec[2] = b;
		vec[3] = a;
		glColorTableParameterfv(target,name,vec);

void
glCopyColorTable ( target, internalFormat, x, y, width )
	GLenum target
	GLenum internalFormat
	Sint32 x
	Sint32 y
	Uint32 width
	CODE:
		glCopyColorTable(target,internalFormat,x,y,width);

void
glColorSubTable ( target, start, count, format, type, data )
	Uint32 target
	Uint32 start
	Uint32 count
	Uint32 format
	Uint32 type
	char *data
	CODE:
		glColorSubTable(target,start,count,format,type,data);

void
glCopyColorSubTable ( target, start, x, y, count )
	Uint32 target
	Uint32 start
	Sint32 x
	Sint32 y
	Uint32 count
	CODE:
		glCopyColorSubTable(target,start,x,y,count);

void
glConvolutionFilter2D ( target, internalFormat, width, height, format, type, image )
	Uint32 target
	Uint32 internalFormat
	Uint32 width
	Uint32 height
	Uint32 format
	Uint32 type
	char *image
	CODE:
		glConvolutionFilter2D(target,internalFormat,width,height,format,type,image);

void
glCopyConvolutionFilter2D ( target, internalFormat, x, y, width, height )
	Uint32 target
	Uint32 internalFormat
	Sint32 x
	Sint32 y
	Uint32 width
	Uint32 height
	CODE:
		glCopyConvolutionFilter2D(target,internalFormat,x,y,width,height);

void
glSeparableFilter2D ( target, internalFormat, width, height, format, type, row, column )
	Uint32 target
	Uint32 internalFormat
	Uint32 width
	Uint32 height
	Uint32 format
	Uint32 type
	char *row
	char *column
	CODE:
		glSeparableFilter2D(target,internalFormat,width,height,format,type,row,column);

void
glConvolutionFilter1D ( target, internalFormat, width, format, type, image )
	Uint32 target
	Uint32 internalFormat
	Uint32 width
	Uint32 format
	Uint32 type
	char *image
	CODE:
		glConvolutionFilter1D(target,internalFormat,width,format,type,image);

void
glCopyConvolutionFilter1D ( target, internalFormat, x, y, width )
	Uint32 target
	Uint32 internalFormat
	Sint32 x
	Sint32 y
	Uint32 width
	CODE:
		glCopyConvolutionFilter1D(target,internalFormat,x,y,width);

void
glConvolutionParameter ( target, pname, ... )
	Uint32 target
	Uint32 pname
	CODE:
		Uint32 pi;
		GLfloat pv[4];
		switch(pname) {	
		case GL_CONVOLUTION_BORDER_MODE:
			if ( items != 3 ) 
				Perl_croak(aTHX_ "Usage: ConvolutionParameter(target,pname,...)");
			pi = SvIV(ST(2));
			glConvolutionParameteri(target,pname,pi);
			break;
		case GL_CONVOLUTION_FILTER_SCALE:
		case GL_CONVOLUTION_FILTER_BIAS:
			if ( items != 6 ) 
				Perl_croak(aTHX_ "Usage: ConvolutionParameter(target,pname,...)");
			pv[0] = (GLfloat)SvNV(ST(2));
			pv[1] = (GLfloat)SvNV(ST(3));
			pv[2] = (GLfloat)SvNV(ST(4));
			pv[3] = (GLfloat)SvNV(ST(5));
			glConvolutionParameterfv(target,pname,pv);
			break;
		default:
			Perl_croak(aTHX_ "ConvolutionParameter invalid parameter");
			break;
		}

void 
glHistogram ( target, width, internalFormat, sink )
	Uint32 target
	Uint32 width
	Uint32 internalFormat
	GLboolean sink
	CODE:
		glHistogram(target,width,internalFormat,sink);

void
glGetHistogram ( target, reset, format, type, values )
	Uint32 target 
	GLboolean reset
	Uint32 format
	Uint32 type
	char *values
	CODE:
		glGetHistogram(target,reset,format,type,values);

void
glResetHistogram ( target )
	Uint32 target
	CODE:
		glResetHistogram(target);

void
glMinmax ( target, internalFormat, sink )
	Uint32 target
	Uint32 internalFormat
	GLboolean sink
	CODE:
		glMinmax(target,internalFormat,sink);

void
glGetMinmax ( target, reset, format, type, values )
	Uint32 target
	GLboolean reset
	Uint32 format
	Uint32 type
	char *values
	CODE:
		glGetMinmax(target,reset,format,type,values);

void
glResetMinmax ( target )
	Uint32 target
	CODE:
		glResetMinmax(target);

void
glBlendEquation ( mode )
	Uint32 mode
	CODE:
		glBlendEquation(mode);

void
glTexImage2D ( target, level, internalFormat, width, height, border, format, type, data )
	GLenum target
	Sint32 level
	Sint32 internalFormat
	Uint32 width
	Uint32 height
	Sint32 border
	GLenum format
	GLenum type
	char *data
	CODE:
		glTexImage2D(target,level,internalFormat,width,height,border,format,type,data);
	
void
glCopyTexImage2D ( target, level, internalFormat, x, y, width, height, border )
	GLenum target
	Sint32 level
	Sint32 internalFormat
	Sint32 x
	Sint32 y
	Uint32 width
	Uint32 height
	Sint32 border
	CODE:
		glCopyTexImage2D(target,level,internalFormat,x,y,width,height,border);

void
glTexSubImage2D ( target, level, xoffset, yoffset, width, height, format, type, data )
	GLenum target
	Sint32 level
	Sint32 xoffset
	Sint32 yoffset
	Uint32 width
	Uint32 height
	GLenum format
	GLenum type
	char *data	
	CODE:
		glTexSubImage2D(target,level,xoffset,yoffset,width,height,format,type,data);

void
glCopyTexSubImage2D ( target, level, xoffset, yoffset, x, y, width, height )
	GLenum target
	Sint32 level
	Sint32 xoffset
	Sint32 yoffset
	Sint32 x
	Sint32 y
	Uint32 width
	Uint32 height
	CODE:
		glCopyTexSubImage2D(target,level,xoffset,yoffset,x,y,width,height);

void
glTexImage1D ( target, level, internalFormat, width, border, format, type, data )
	GLenum target
	Sint32 level
	Sint32 internalFormat
	Uint32 width
	Sint32 border
	GLenum format
	GLenum type
	char *data	
	CODE:
		glTexImage1D(target,level,internalFormat,width,border,format,type,data);	

void
glTexSubImage1D ( target, level, xoffset, width, format, type, data )
	GLenum target
	Sint32 level
	Sint32 xoffset 
	Uint32 width
	GLenum format
	GLenum type
	char *data	
	CODE:
		glTexSubImage1D(target,level,xoffset,width,format,type,data);

void
glCopyTexImage1D ( target, level, internalFormat, x, y, width, border )
	GLenum target
	Sint32 level
	Sint32 internalFormat
	Sint32 x
	Sint32 y
	Uint32 width
	Sint32 border
	CODE:
		glCopyTexImage1D(target,level,internalFormat,x,y,width,border);

void
glCopyTexSubImage1D ( target, level, xoffset, x, y, width )
	GLenum target
	Sint32 level
	Sint32 xoffset
	Sint32 x
	Sint32 y
	Uint32 width
	CODE:
		glCopyTexSubImage1D(target,level,xoffset,x,y,width);

void
glTexImage3D ( target, level, internalFormat, width, height, depth, border, format, type, data )
	GLenum target
	Sint32 level
	Sint32 internalFormat
	Uint32 width
	Uint32 height
	Uint32 depth
	Sint32 border
	GLenum format
	GLenum type
	char *data
	CODE:
		glTexImage3D(target,level,internalFormat,width,height,depth,border,format,type,data);

void
glTexSubImage3D ( target, level, xoffset, yoffset, zoffset, width, height, depth, format, type, data )
	GLenum target
	Sint32 level
	Sint32 xoffset
	Sint32 yoffset
	Sint32 zoffset
	Uint32 width
	Uint32 height
	Uint32 depth
	GLenum format
	GLenum type
	char *data
	CODE:
		glTexSubImage3D(target,level,xoffset,yoffset,zoffset,
			width,height,depth,format,type,data);

void
glCopyTexSubImage3D ( target, level, xoffset, yoffset, zoffset, x, y, width, height )
	GLenum target
	Sint32 level
	Sint32 xoffset
	Sint32 yoffset
	Sint32 zoffset
	Sint32 x
	Sint32 y
	Uint32 width
	Uint32 height
	CODE:
		glCopyTexSubImage3D(target,level,xoffset,yoffset,zoffset,x,y,width,height);

AV*
glGenTextures ( n )
	Uint32 n;
	CODE:
		Uint32 i;
		Uint32 *names;
		names = (Uint32*)safemalloc(sizeof(Uint32)*n);
		RETVAL = newAV();
		glGenTextures(n,names);
		for ( i = 0; i < n; i++ ) {
			av_push(RETVAL,newSViv(names[i]));
		}
		safefree(names);
	OUTPUT:
		RETVAL

GLboolean
glIsTexture ( texture )
	Uint32 texture
	CODE:
		RETVAL = glIsTexture(texture);
	OUTPUT:
		RETVAL

void
glBindTexture ( target, texture )
	GLenum target
	Uint32 texture
	CODE:
		glBindTexture(target,texture);

void
glDeleteTextures ( ... )
	CODE:
		Uint32 *textures;
		int i;
		textures = (Uint32*)safemalloc(sizeof(Uint32) * items);
		if ( textures ) {
	 		for ( i = 0; i < items; i++ ) {
				textures[i] = SvIV(ST(i));	
			}
		}
		glDeleteTextures(items,textures);
		safefree(textures);
			 
AV*
glAreTexturesResident ( ... )
	CODE:
		Uint32 *textures;
		GLboolean *homes;
		int i;
		RETVAL = newAV();
		textures = (Uint32*)safemalloc(sizeof(Uint32) * items);
		homes = (GLboolean*)safemalloc(sizeof(GLboolean) * items);
		if ( textures ) {
	 		for ( i = 0; i < items; i++ ) {
				textures[i] = SvIV(ST(i));	
			}
		}
		if ( GL_FALSE != glAreTexturesResident(items,textures,homes)) {
			for (i = 0; i < items; i++ ) {
				av_push(RETVAL,newSViv(homes[i]));	
			}
		}
		safefree(homes);
		safefree(textures);
	OUTPUT:
		RETVAL

void
glPrioritizeTextures ( n, names, priorities )
	Uint32 n
	char *names
	char *priorities
	CODE:
		glPrioritizeTextures(n,(GLuint*)names,(const GLclampf *)priorities);

void
glTexEnv ( target, name, ... )
	GLenum target
	GLenum name
	CODE:
		float pv[4];
		GLint p;	
		switch(name) {
			case GL_TEXTURE_ENV_MODE:
				p = SvIV(ST(2));
				glTexEnvi(target,name,p);	
				break;
			case GL_TEXTURE_ENV_COLOR:
				pv[0] = SvNV(ST(2));
				pv[1] = SvNV(ST(3));
				pv[2] = SvNV(ST(4));
				pv[3] = SvNV(ST(5));
				glTexEnvfv(target,name,pv);
				break;
		}

void
glTexCoord ( ... )
	CODE:
		double s,t,r,q;
		if ( items < 1 || items > 4 ) 
			Perl_croak (aTHX_ "usage: SDL::OpenGL::TexCoord(s,[t,[r,[q]]])");
		s = t = r = 0.0;
		q = 1.0;
		switch(items) {
			case 4:
				q = SvNV(ST(3)); 
			case 3:
				r = SvNV(ST(2)); 
			case 2:
				t = SvNV(ST(1)); 
			case 1:
				s = SvNV(ST(0));	
		}
		glTexCoord4d(s,t,r,q);

void
glTexParameter ( target, name, ... )
	GLenum target
	GLenum name
	CODE:
		GLfloat pv[4];
		GLint p;
		switch (name) {
			case GL_TEXTURE_BORDER_COLOR:
				pv[0] = SvNV(ST(2));
				pv[1] = SvNV(ST(3));
				pv[2] = SvNV(ST(4));
				pv[3] = SvNV(ST(5));
				glTexParameterfv(target,name,pv);
				break;
			case GL_TEXTURE_PRIORITY:
			case GL_TEXTURE_MIN_LOD:
			case GL_TEXTURE_MAX_LOD:
				pv[0] = SvNV(ST(2));
				glTexParameterf(target,name,pv[0]);	
				break;
			case GL_TEXTURE_BASE_LEVEL:
			case GL_TEXTURE_MAX_LEVEL:
			default:
				p = SvIV(ST(2));	
				glTexParameteri(target,name,p);
				break;
		}

void
glTexGen ( coord, name, ... )
	GLenum coord
	GLenum name	
	CODE:
		GLdouble *pv;
		GLint p;
		int i;
		switch (name) {
			case GL_TEXTURE_GEN_MODE:
				p = SvIV(ST(2));
				glTexGeni(coord,name,p);
				break;
			default:
				if ( items == 2 ) 
					Perl_croak(aTHX_  "usage: glTexGen(coord,name,...)");
				pv = (GLdouble*)safemalloc(sizeof(GLdouble)*(items-2));
				for ( i = 0; i < items - 2; i++ ) {
					pv[i] = SvNV(ST(i+2));	
				}
				glTexGendv(coord,name,pv);	
				safefree(pv);
				break;
		}

void
glActiveTextureARB ( texUnit )
	GLenum texUnit
	CODE:
		glActiveTextureARB(texUnit);
				
void
glMultiTexCoord ( texUnit,  ... )
	Uint32 texUnit
	CODE:
		double s,t,r,q;
		if ( items < 2 || items > 5 ) 
			Perl_croak (aTHX_ "usage: SDL::OpenGL::MultiTexCoord(tex,s,[t,[r,[q]]])");
		s = t = r = 0.0;
		q = 1.0;
		switch(items) {
			case 5:
				q = SvNV(ST(3)); 
			case 4:
				r = SvNV(ST(2)); 
			case 3:
				t = SvNV(ST(1)); 
			case 2:
				s = SvNV(ST(0));	
		}
		glMultiTexCoord4dARB(texUnit,s,t,r,q);

void
glDrawBuffer ( mode )
	GLenum mode
	CODE:
		glDrawBuffer(mode);

void
glReadBuffer ( mode )
	GLenum mode
	CODE:
		glReadBuffer(mode);

void
glIndexMask ( mask )
	Uint32 mask
	CODE:
		glIndexMask(mask);

void
glColorMask ( red, green, blue, alpha )
	GLboolean red
	GLboolean green 
	GLboolean blue 
	GLboolean alpha 
	CODE:
		glColorMask(red,green,blue,alpha);

void
glDepthMask ( flag )
	GLboolean flag
	CODE:
		glDepthMask(flag);

void
glStencilMask ( mask )
	Uint32 mask
	CODE:
		glStencilMask(mask);

void
glScissor ( x , y, width, height )
	Sint32 x
	Sint32 y
	Uint32 width
	Uint32 height 
	CODE:
		glScissor(x,y,width,height);

void
glAlphaFunc ( func, ref )
	GLenum func
	double ref
	CODE:
		glAlphaFunc(func,ref);

void
glStencilFunc ( func, ref, mask )
	GLenum func
	Sint32 ref
	Uint32 mask
	CODE:
		glStencilFunc(func,ref,mask);

void
glStencilOp ( fail, zfail, zpass )
	GLenum fail
	GLenum zfail
	GLenum zpass
	CODE:
		glStencilOp(fail,zfail,zpass);

void
glDepthFunc ( func )
	GLenum func
	CODE:
		glDepthFunc(func);

void
glLogicOp ( opcode )
	GLenum opcode
	CODE:
		glLogicOp(opcode);

void
glAccum ( op, value )
	GLenum op
	double value
	CODE:
		glAccum(op,value);

void
glMap1 ( target, u1, u2, stride, order, points )
	GLenum target
	double u1
	double u2
	Sint32 stride
	Sint32 order
	char *points
	CODE:
		glMap1d(target,u1,u2,stride,order,(double*)points);

void
glEvalCoord1 ( u )
	double u
	CODE:
		glEvalCoord1d(u);	

void
glMapGrid1 ( n, u1, u2 )
	Sint32 n
	double u1
	double u2
	CODE:
		glMapGrid1d(n,u1,u2);

void
glEvalMesh1 ( mode, p1, p2 )
	GLenum mode
	Sint32 p1
	Sint32 p2
	CODE:
		glEvalMesh1(mode,p1,p2);

void
glMap2 ( target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points )
	GLenum target
	double u1
	double u2
	Sint32 ustride
	Sint32 uorder
	double v1
	double v2
	Sint32 vstride
	Sint32 vorder
	char *points
	CODE:
		glMap2d(target,u1,u2,ustride,uorder,v1,v2,vstride,vorder,(double*)points);

void
glEvalCoord2 ( u, v )
	double u
	double v
	CODE:
		glEvalCoord2d(u,v);

void
glMapGrid2 ( nu, u1, u2, nv, v1, v2 )
	Sint32 nu
	double u1
	double u2
	Sint32 nv
	double v1
	double v2
	CODE:
		glMapGrid2d(nu,u1,u2,nv,v1,v2);

void
glEvalMesh2 ( mode, i1, i2, j1, j2 )
	GLenum mode
	Sint32 i1
	Sint32 i2
	Sint32 j1
	Sint32 j2
	CODE:
		glEvalMesh2(mode,i1,i2,j1,j2);

GLenum
glGetError ( )
	CODE:
		RETVAL = glGetError();
	OUTPUT:
		RETVAL
	
void
glInitNames ( )
	CODE:
		glInitNames();

void
glPushName ( name )
	GLuint name
	CODE:
		glPushName(name);

void
glPopName ( )
	CODE:
		glPopName();		

void
glLoadName ( name )
	GLuint name
	CODE:
		glLoadName(name);
	
void
glFeedbackBuffer ( size, type, buffer )
	GLuint size
	GLenum type
	float* buffer
	CODE:
		glFeedbackBuffer(size,type,buffer);		

void
glPassThrough ( token )
	GLfloat token
	CODE:
		glPassThrough(token);


#endif

#ifdef HAVE_GLU

void
gluLookAt ( eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz )
	double eyex
	double eyey
	double eyez
	double centerx
	double centery
	double centerz
	double upx
	double upy
	double upz
	CODE:
		gluLookAt(eyex,eyey,eyez,centerx,centery,centerz,upx,upy,upz);

void
gluPerspective ( fovy, aspect, n, f )
	double fovy
	double aspect
	double n
	double f
	CODE:
		gluPerspective(fovy,aspect,n,f);

void
gluOrtho2D ( left, right, bottom, top )
	double left
	double right
	double bottom
	double top
	CODE:
		gluOrtho2D(left,right,bottom,top);

int
gluScaleImage ( format, widthin, heightin, typein, datain, widthout, heightout, typeout, dataout )
	GLenum format
	Uint32 widthin
	Uint32 heightin
	GLenum typein
	char *datain
	Uint32 widthout
	Uint32 heightout
	GLenum typeout
	char *dataout
	CODE:
		RETVAL = gluScaleImage(format,widthin,heightin,typein,datain,
				widthout,heightout,typeout,dataout);
	OUTPUT:
		RETVAL

int
gluBuild1DMipmaps ( target, internalFormat, width, format, type, data )
	GLenum target
	Sint32 internalFormat
	Uint32 width
	GLenum format
	GLenum type
	char *data
	CODE:
		RETVAL = gluBuild1DMipmaps(target,internalFormat,width,format,type,data);
	OUTPUT:
		RETVAL

int
gluBuild2DMipmaps ( target, internalFormat, width, height, format, type, data )
	GLenum target
	Sint32 internalFormat
	Uint32 width
	Uint32 height 
	GLenum format
	GLenum type
	char *data
	CODE:
		RETVAL = gluBuild2DMipmaps(target,internalFormat,width,height,format,type,data);
	OUTPUT: 
		RETVAL


#if HAVE_GLU_VERSION >= 12
int
gluBuild3DMipmaps ( target, internalFormat, width, height, depth, format, type, data )
	GLenum target
	Sint32 internalFormat
	Uint32 width
	Uint32 height 
	Uint32 depth 
	GLenum format
	GLenum type
	char *data
	CODE:
		RETVAL = gluBuild3DMipmaps(target,internalFormat,width,height,depth,
				format,type,data);
	OUTPUT: 
		RETVAL

#else
void
gluBuild3DMipmaps ( )
	CODE:
		Perl_croak (aTHX_ "SDL::OpenGL::Build3DMipmaps requires GLU 1.2");

#endif

#if HAVE_GLU_VERSION >= 12
int
gluBuild1DMipmapLevels ( target, internalFormat, width, format, type, level, base, max, data )
	GLenum target
	Sint32 internalFormat
	Uint32 width
	GLenum format
	GLenum type
	Sint32 level
	Sint32 base
	Sint32 max
	char *data
	CODE:
		RETVAL = gluBuild1DMipmapLevels(target,internalFormat,width,
				format,type,level,base,max,data);
	OUTPUT:
		RETVAL

#else
void
gluBuild1DMipmapLevels ()
	CODE:
		Perl_croak(aTHX_ "SDL::OpenGL::Build1DMipmapLevels requires GLU 1.2");		
	
#endif

#if HAVE_GLU_VERSION >= 12
int
gluBuild2DMipmapLevels ( target, internalFormat, width, height, format, type, level, base, max, data )
	GLenum target
	Sint32 internalFormat
	Uint32 width
	Uint32 height 
	GLenum format
	GLenum type
	Sint32 level
	Sint32 base
	Sint32 max
	char *data
	CODE:
		RETVAL = gluBuild2DMipmapLevels(target,internalFormat,width,height,
				format,type,level,base,max,data);
	OUTPUT:
		RETVAL

#else
void
gluBuild2DMipmapLevels ()
	CODE:
		Perl_croak(aTHX_ "SDL::OpenGL::Build2DMipmapLevels requires GLU 1.2");		

#endif

#if HAVE_GLU_VERSION >= 12
int
gluBuild3DMipmapLevels ( target, internalFormat, width, height, depth, format, type, level, base, max, data )
	GLenum target
	Sint32 internalFormat
	Uint32 width
	Uint32 height 
	Uint32 depth 
	GLenum format
	GLenum type
	Sint32 level
	Sint32 base
	Sint32 max
	char *data
	CODE:
		RETVAL = gluBuild3DMipmapLevels(target,internalFormat,width,height,depth,
				format,type,level,base,max,data);
	OUTPUT:
		RETVAL

#else
void
gluBuild3DMipmapLevels ()
	CODE:
		Perl_croak(aTHX_ "SDL::OpenGL::Build3DMipmapLevels requires GLU 1.2");		

#endif

char*
gluErrorString ( code )
	GLenum code
	CODE:
		RETVAL = (char*)gluErrorString(code);
	OUTPUT:
		RETVAL

GLUnurbsObj*
gluNewNurbsRenderer ()
	CODE:
		RETVAL = gluNewNurbsRenderer();
	OUTPUT:
		RETVAL

void
gluDeleteNurbsRenderer ( obj )
	GLUnurbsObj *obj
	CODE:
		gluDeleteNurbsRenderer(obj);

void
gluNurbsProperty ( obj, property, value )
	GLUnurbsObj *obj
	GLenum property
	double value
	CODE:
		gluNurbsProperty(obj,property,(float)value);

void
gluLoadSamplingMatrices ( obj, mm, pm, vp )
	GLUnurbsObj *obj
	char *mm
	char *pm
	char *vp
	CODE:
		gluLoadSamplingMatrices(obj,(GLfloat*)mm,(GLfloat*)pm,(GLint*)vp);

double
gluGetNurbsProperty ( obj, property )
	GLUnurbsObj *obj
	GLenum property
	CODE:
		float f;
		gluGetNurbsProperty(obj,property,&f);
		RETVAL = (double)f;
	OUTPUT:
		RETVAL

void
gluNurbsCallback ( obj, which, cb )
	GLUnurbsObj *obj
	GLenum which
	SV *cb
	CODE:
		switch(which) {
			case GLU_ERROR:
				sdl_perl_nurbs_error_hook = cb;
				gluNurbsCallback(obj,GLU_ERROR,(GLvoid*)sdl_perl_nurbs_error_callback);
				break;
#ifdef GLU_NURBS_BEGIN
			case GLU_NURBS_BEGIN:
			case GLU_NURBS_BEGIN_DATA:
				gluNurbsCallbackData(obj,(void*)cb);
				gluNurbsCallback(obj,GLU_NURBS_BEGIN_DATA,
					(GLvoid*)sdl_perl_nurbs_being_callback);	
				break;
			case GLU_NURBS_TEXTURE_COORD:
			case GLU_NURBS_TEXTURE_COORD_DATA:
				gluNurbsCallbackData(obj,(void*)cb);
				gluNurbsCallback(obj,GLU_NURBS_TEXTURE_COORD_DATA,
					(GLvoid*)sdl_perl_nurbs_multi_callback);	
				break;
			case GLU_NURBS_COLOR:
			case GLU_NURBS_COLOR_DATA:
				gluNurbsCallbackData(obj,(void*)cb);
				gluNurbsCallback(obj,GLU_NURBS_COLOR_DATA,
					(GLvoid*)sdl_perl_nurbs_multi_callback);	
				break;
			case GLU_NURBS_NORMAL:
			case GLU_NURBS_NORMAL_DATA:
				gluNurbsCallbackData(obj,(void*)cb);
				gluNurbsCallback(obj,GLU_NURBS_NORMAL_DATA,
					(GLvoid*)sdl_perl_nurbs_multi_callback);	
				break;
			case GLU_NURBS_VERTEX:
			case GLU_NURBS_VERTEX_DATA:
				gluNurbsCallbackData(obj,(void*)cb);
				gluNurbsCallback(obj,GLU_NURBS_VERTEX_DATA,
					(GLvoid*)sdl_perl_nurbs_multi_callback);	
				break;
			case GLU_NURBS_END:
			case GLU_NURBS_END_DATA:
				gluNurbsCallbackData(obj,(void*)cb);
				gluNurbsCallback(obj,GLU_NURBS_END_DATA,
					(GLvoid*)sdl_perl_nurbs_end_callback);	
				break;
#endif
			default:
				Perl_croak(aTHX_ "SDL::OpenGL::NurbsCallback - invalid type");
		}

void
gluNurbsCallbackData ( obj, cb )
	GLUnurbsObj *obj
	SV *cb
	CODE:
		gluNurbsCallbackData(obj,(void*)cb);

void
gluBeginSurface ( obj )
	GLUnurbsObj *obj
	CODE:
		gluBeginSurface(obj);

void
gluEndSurface ( obj )
	GLUnurbsObj *obj
	CODE:
		gluEndSurface(obj);
	
void
gluNurbsSurface ( obj, uknot_count, uknot, vknot_count, vknot, u_stride, v_stride, ctlarray, uorder, vorder, type )
	GLUnurbsObj *obj
	Sint32 uknot_count
	char *uknot
	Sint32 vknot_count
	char *vknot
	Sint32 u_stride
	Sint32 v_stride
	char *ctlarray
	Sint32 uorder
	Sint32 vorder
	GLenum type
	CODE:
		gluNurbsSurface(obj,uknot_count,(GLfloat*)uknot,vknot_count,(GLfloat*)vknot,
			u_stride,v_stride,(GLfloat*)ctlarray,uorder,vorder,type);

void
gluBeginCurve ( obj )
	GLUnurbsObj *obj
	CODE:
		gluBeginCurve(obj);

void
gluEndCurve ( obj ) 
	GLUnurbsObj *obj
	CODE:
		gluEndCurve(obj);

void
gluNurbsCurve ( obj, uknot_count, uknot, u_stride, ctlarray, uorder, type )
	GLUnurbsObj *obj
	Sint32 uknot_count
	char *uknot
	Sint32 u_stride
	char *ctlarray
	Sint32 uorder
	GLenum type
	CODE:
		gluNurbsCurve(obj,uknot_count,(GLfloat*)uknot,u_stride,(GLfloat*)ctlarray,
			uorder,type);

void
gluBeginTrim ( obj )
	GLUnurbsObj *obj
	CODE:
		gluBeginTrim(obj);

void
gluEndTrim ( obj )
	GLUnurbsObj *obj
	CODE:
		gluEndTrim(obj);

void
gluPwlCurve ( obj, count, array, stride, type )	
	GLUnurbsObj *obj
	Sint32 count
	char *array
	Sint32 stride
	GLenum type
	CODE:
		gluPwlCurve(obj,count,(GLfloat*)array,stride,type);

AV*
gluUnProject ( winx, winy, winz, mm, pm, vp )
	double winx
	double winy
	double winz
	char *mm
	char *pm
	char *vp
	CODE:
		GLdouble objx, objy, objz;
		RETVAL = newAV();
		av_push(RETVAL,newSViv(gluUnProject(winx,winy,winz,(GLdouble*)mm,
			(GLdouble*)pm,(GLint*)vp,&objx,&objy,&objz)));
		av_push(RETVAL,newSVnv((double)objx));
		av_push(RETVAL,newSVnv((double)objy));
		av_push(RETVAL,newSVnv((double)objz));
	OUTPUT:
		RETVAL
		
AV*
gluUnProject4 ( winx, winy, winz, clipw, mm, pm, vp, n, f )
        double winx
        double winy
        double winz
	double clipw
        char *mm
        char *pm
        char *vp
	double n
	double f
        CODE:
                GLdouble objx, objy, objz, objw;
                RETVAL = newAV();
                av_push(RETVAL,newSViv(gluUnProject4(winx,winy,winz,clipw,(GLdouble*)mm,
                        (GLdouble*)pm,(GLint*)vp,(GLclampd)n,(GLclampd)f,
			&objx,&objy,&objz,&objw)));
                av_push(RETVAL,newSVnv((double)objx));
                av_push(RETVAL,newSVnv((double)objy));
                av_push(RETVAL,newSVnv((double)objz));
                av_push(RETVAL,newSVnv((double)objw));
        OUTPUT:
                RETVAL

AV*
gluProject ( objx, objy, objz, mm, pm, vp )
	double objx
	double objy
	double objz
	char *mm
	char *pm
	char *vp
	CODE:
		GLdouble winx, winy, winz;
		RETVAL = newAV();
		av_push(RETVAL,newSViv(gluUnProject(objx,objy,objz,(GLdouble*)mm,
			(GLdouble*)pm,(GLint*)vp,&winx,&winy,&winz)));
                av_push(RETVAL,newSVnv((double)winx));
                av_push(RETVAL,newSVnv((double)winy));
                av_push(RETVAL,newSVnv((double)winz));
	OUTPUT:
		RETVAL

#ifdef GLUtesselator
GLUtesselator*
gluNewTess ()
	CODE:
		RETVAL = gluNewTess();
	OUTPUT:
		RETVAL

void
gluTessCallback ( tess, type )
	GLUtesselator *tess
	GLenum type
	CODE:
		switch(type) {
			case GLU_TESS_BEGIN:
			case GLU_TESS_BEGIN_DATA:
				gluTessCallback(tess,GLU_TESS_BEGIN_DATA,
					(GLvoid*)sdl_perl_tess_begin_callback);	
				break;
	
			case GLU_TESS_EDGE_FLAG:
			case GLU_TESS_EDGE_FLAG_DATA:
				gluTessCallback(tess,GLU_TESS_EDGE_FLAG_DATA,
					(GLvoid*)sdl_perl_tess_edge_flag_callback);	
				break;

			case GLU_TESS_VERTEX:
			case GLU_TESS_VERTEX_DATA:
				gluTessCallback(tess,GLU_TESS_VERTEX_DATA,
					(GLvoid*)sdl_perl_tess_vertex_callback);	
				break;

			case GLU_TESS_END:
			case GLU_TESS_END_DATA:
				gluTessCallback(tess,GLU_TESS_END_DATA,
					(GLvoid*)sdl_perl_tess_end_callback);	
				break;

			case GLU_TESS_COMBINE:
			case GLU_TESS_COMBINE_DATA:
				gluTessCallback(tess,GLU_TESS_COMBINE_DATA,
					(GLvoid*)sdl_perl_tess_combine_callback);	
				break;

			case GLU_TESS_ERROR:
			case GLU_TESS_ERROR_DATA:
				gluTessCallback(tess,GLU_TESS_ERROR_DATA,
					(GLvoid*)sdl_perl_tess_error_callback);	
				break;
		}

void
gluTessProperty ( tessobj, property, value )
	GLUtesselator *tessobj
	Uint32 property
	double value
	CODE:
		gluTessProperty(tessobj,property,value);

double
gluGetTessProperty ( tessobj, property )
	GLUtesselator *tessobj
	Uint32 property
	CODE:
		gluGetTessProperty(tessobj,property,&RETVAL);
	OUTPUT:
		RETVAL

void
gluTessNormal ( tessobj, x, y, z )
	GLUtesselator *tessobj
	double x
	double y
	double z
	CODE:
		gluTessNormal(tessobj,x,y,z);

void
gluTessBeginPolygon ( tessobj, cb )
	GLUtesselator *tessobj
	SV *cb
	CODE:
		gluTessBeginPolygon(tessobj,cb);

void
gluTessEndPolygon ( tessobj ) 
	GLUtesselator *tessobj
	CODE:
		gluTessEndPolygon(tessobj);

void
gluTessBeginContour ( tessobj )
	GLUtesselator *tessobj
	CODE:
		gluTessBeginContour(tessobj);

void
gluTessEndContour ( tessobj )
	GLUtesselator *tessobj
	CODE:
		gluTessEndContour(tessobj);

void
gluDeleteTess ( tessobj )
	GLUtesselator *tessobj
	CODE:
		gluDeleteTess(tessobj);

void
gluTessVertex ( tessobj, coords, vd ) 
	GLUtesselator *tessobj
	char *coords
	char *vd
	CODE:
		gluTessVertex(tessobj,(GLdouble*)coords,vd);
	
#endif
#endif

