#include <stdio.h>
#include <stdlib.h>
#include <GL/gl.h>
#include <GL/glu.h>

int
main ( int argc, char **argv )
{
	fprintf(stdout,"%g",atof((const char*)gluGetString(GLU_VERSION)));
}
