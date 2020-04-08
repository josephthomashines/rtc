#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "primitives.h"
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

  return p;
}

Primitive* new_point(float x, float y, float z) {
  return new_primitive(x,y,z,POINT_W);
}

Primitive* new_vector(float x, float y, float z) {
  return new_primitive(x,y,z,VECTOR_W);
}

void free_primitive(Primitive* p) {
  free(p->values);
  free(p);

  return;
}

char* toString(Primitive* p) {
  int BUF_SIZE = PRIMITIVE_SIZE*5;
  char* out = calloc(1,sizeof(char)*(BUF_SIZE));

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

  return out;
}

Primitive* add_primitives(Primitive* a, Primitive* b) {
  float nx = (a->values)[0] + (b->values)[0];
  float ny = (a->values)[1] + (b->values)[1];
  float nz = (a->values)[2] + (b->values)[2];
  float nw = (a->values)[3] + (b->values)[3];

  // Check for error state (point+point)
  if (!floatEquals(nw,0) && !floatEquals(nw,1)) {
    exit(EXIT_FAILURE);
  }

  return new_primitive(nx,ny,nz,nw);
}
