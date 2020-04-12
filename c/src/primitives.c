#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "primitives.h"
#include "resource.h"
#include "util.h"

// A basic primitive is just a list of float values
typedef struct Primitive {
  float* values;
} Primitive;

Primitive* new_primitive(float x, float y, float z, float w) {
  float* values = malloc(sizeof(float)*PRIMITIVE_SIZE);
  values[0] = x; values[1] = y;
  values[2] = z; values[3] = w;

  Primitive* p = malloc(sizeof(Primitive));
  p->values = values;

  push_resource(global_resources(),p,free_primitive);
  return p;
}

Primitive* new_point(float x, float y, float z) {
  return new_primitive(x,y,z,POINT_W);
}

Primitive* new_vector(float x, float y, float z) {
  return new_primitive(x,y,z,VECTOR_W);
}

int is_point(Primitive* p) {
  int w = (p->values)[3];

  return floatEquals(w,POINT_W);
}

int is_vector(Primitive* p){
  int w = (p->values)[3];

  return floatEquals(w,VECTOR_W);
}

void free_primitive(Primitive* p) {
  free(p->values);
  free(p);

  return;
}

char* toString(Primitive* p) {
  int BUF_SIZE = PRIMITIVE_SIZE*32;
  char* out = (char*)calloc(1,sizeof(char)*(BUF_SIZE));

  for (int i=0;i<PRIMITIVE_SIZE;i++) {
    if (i != 3) {
      int n = sprintf(out+strlen(out),"%0.2f,",(p->values)[i]);
      if (n < 0) {
        perror("Error printing Primitive to string.");
        exit(EXIT_FAILURE);
      }
    } else {
      int n = sprintf(out+strlen(out),"%0.2f",(p->values)[i]);
      if (n < 0) {
        perror("Error printing Primitive to string.");
        exit(EXIT_FAILURE);
      }
    }
  }

  push_resource(global_resources(),out,free);
  return out;
}

int primitivesEqual(Primitive* a, Primitive* b) {
  int xs = floatEquals((a->values)[0],(b->values)[0]);
  int ys = floatEquals((a->values)[1],(b->values)[1]);
  int zs = floatEquals((a->values)[2],(b->values)[2]);
  int ws = floatEquals((a->values)[3],(b->values)[3]);

  return (xs && ys && zs && ws);
}

Primitive* add_primitives(Primitive* a, Primitive* b) {
  float nx = (a->values)[0] + (b->values)[0];
  float ny = (a->values)[1] + (b->values)[1];
  float nz = (a->values)[2] + (b->values)[2];
  float nw = (a->values)[3] + (b->values)[3];

  // Check for error state (point+point)
  if (!floatEquals(nw,0) && !floatEquals(nw,1)) {
    perror("Cannot add two points together");
    exit(EXIT_FAILURE);
  }

  return new_primitive(nx,ny,nz,nw);
}

Primitive* sub_primitives(Primitive* a, Primitive* b) {
  float nx = (a->values)[0] - (b->values)[0];
  float ny = (a->values)[1] - (b->values)[1];
  float nz = (a->values)[2] - (b->values)[2];
  float nw = (a->values)[3] - (b->values)[3];

  // Check for error state (point+point)
  if (!floatEquals(nw,0) && !floatEquals(nw,1)) {
    perror("Cannot subtract a point from a vector");
    exit(EXIT_FAILURE);
  }

  return new_primitive(nx,ny,nz,nw);
}

Primitive* scale_primitive(Primitive* p, float s) {
  float nx = (p->values)[0] *= s;
  float ny = (p->values)[1] *= s;
  float nz = (p->values)[2] *= s;
  float nw = (p->values)[3];

  return new_primitive(nx,ny,nz,nw);
}

Primitive* negate_primitive(Primitive* p) {
  return scale_primitive(p,-1);
}
