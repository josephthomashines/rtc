#ifndef __MATRIX_H__
#define __MATRIX_H__

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include "util.h"

typedef struct matrix_t {
	int w; int h;
	float** v;
} matrix_t;

matrix_t* new_matrix(int w, int h);
matrix_t* new_identity_matrix(int w, int h);
char* matrix_to_string(matrix_t* m);
void free_matrix(matrix_t* m);
int matrix_equals(matrix_t* a, matrix_t* b);
matrix_t* matrix_mult(matrix_t* a, matrix_t* b);

#endif

