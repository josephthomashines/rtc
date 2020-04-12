#ifndef __PRIMITIVES_H__
#define __PRIMITIVES_H__

// Constants
#define PRIMITIVE_SIZE 4
#define POINT_W 1
#define VECTOR_W 0

// Types
typedef struct Primitive Primitive;
Primitive* new_primitive(float x, float y, float z, float w);

// Functions
Primitive* new_point(float x, float y, float z);
Primitive* new_vector(float x, float y, float z);
int is_point(Primitive* p);
int is_vector(Primitive* p);
void free_primitive(Primitive* p);
char* toString(Primitive* p);
int primitivesEqual(Primitive* a, Primitive* b);

Primitive* add_primitives(Primitive* a, Primitive* b);
Primitive* sub_primitives(Primitive* a, Primitive* b);
Primitive* scale_primitive(Primitive* p, float s);
Primitive* negate_primitive(Primitive* p);


// Globals

#endif
