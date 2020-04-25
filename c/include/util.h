#ifndef __UTIL_H__
#define __UTIL_H__

#include <stdlib.h>
#include <stdio.h>

#include <math.h>

int float_equals(float a, float b);

#define VERIFY_ALLOC(ptr, type) \
	if (ptr == NULL) {\
		fprintf(stderr, "Could not allocate memory for %s\n", type);\
		exit(EXIT_FAILURE);\
	}\

#define CHECK_SPRINTF(n,str)\
	if (n < 0) {\
		fprintf(stderr,str);\
		exit(EXIT_FAILURE);\
	}\

#endif
