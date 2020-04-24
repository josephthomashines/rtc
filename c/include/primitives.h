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
typedef struct primitive_t {
  float* values;
} primitive_t;

// Functions
float primitive_x(primitive_t* p);
float primitive_y(primitive_t* p);
float primitive_z(primitive_t* p);
float primitive_w(primitive_t* p);
primitive_t* new_primitive(float x, float y, float z, float w);
primitive_t* new_point(float x, float y, float z);
primitive_t* new_vector(float x, float y, float z);
int is_point(primitive_t* p);
int is_vector(primitive_t* p);
void free_primitive(primitive_t* p);
char* to_string(primitive_t* p);
int primitives_equal(primitive_t* a, primitive_t* b);

primitive_t* add_primitives(primitive_t* a, primitive_t* b);
primitive_t* sub_primitives(primitive_t* a, primitive_t* b);
primitive_t* scale_primitive(primitive_t* p, float s);
primitive_t* negate_primitive(primitive_t* p);
float magnitude_vector(primitive_t* p);
primitive_t* normalize_vector(primitive_t* p);
float dot_vectors(primitive_t* a, primitive_t* b);
primitive_t* cross_vectors(primitive_t* a, primitive_t* b);


// Globals

#endif
