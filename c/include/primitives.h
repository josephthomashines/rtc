#ifndef __PRIMITIVES_H__
#define __PRIMITIVES_H__

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

// Constants
#define PRIMITIVE_SIZE 4
#define POINT_W 1
#define VECTOR_W 0

// Types
typedef struct Primitive Primitive;
Primitive* new_primitive(float x, float y, float z, float w);

// Functions
float primitive_x(Primitive* p);
float primitive_y(Primitive* p);
float primitive_z(Primitive* p);
float primitive_w(Primitive* p);
Primitive* new_point(float x, float y, float z);
Primitive* new_vector(float x, float y, float z);
int is_point(Primitive* p);
int is_vector(Primitive* p);
void free_primitive(Primitive* p);
char* to_string(Primitive* p);
int primitives_equal(Primitive* a, Primitive* b);

Primitive* add_primitives(Primitive* a, Primitive* b);
Primitive* sub_primitives(Primitive* a, Primitive* b);
Primitive* scale_primitive(Primitive* p, float s);
Primitive* negate_primitive(Primitive* p);
float magnitude_vector(Primitive* p);
Primitive* normalize_vector(Primitive* p);
float dot_vectors(Primitive* a, Primitive* b);
Primitive* cross_vectors(Primitive* a, Primitive* b);


// Globals

#endif
