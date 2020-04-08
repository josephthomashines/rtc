#ifndef __PRIMITIVES_H__
#define __PRIMITIVES_H__

// Constants
#define PRIMITIVE_SIZE 4
#define POINT_W 1
#define VECTOR_W 0

// Base primtive type
typedef struct Primitive Primitive;
Primitive* new_primitive(float x, float y, float z, float w);

// Create the two kinds of primitives
Primitive* new_point(float x, float y, float z);
Primitive* new_vector(float x, float y, float z);

// TODO
void free_primitive(Primitive* p);

// TODO
char* toString(Primitive* p);

// TODO
Primitive* add_primitives(Primitive* a, Primitive* b);

#endif
