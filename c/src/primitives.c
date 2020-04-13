#include "primitives.h"
#include "resource.h"
#include "util.h"

// A basic primitive is just a list of float values
typedef struct Primitive {
  float* values;
} Primitive;

float primitive_x(Primitive* p) {
  return (p->values)[0];
}
float primitive_y(Primitive* p) {
  return (p->values)[1];
}
float primitive_z(Primitive* p) {
  return (p->values)[2];
}
float primitive_w(Primitive* p) {
  return (p->values)[3];
}

Primitive* new_primitive(float x, float y, float z, float w) {
  float* values = malloc(sizeof(float)*PRIMITIVE_SIZE);
  values[0] = x; values[1] = y;
  values[2] = z; values[3] = w;

  Primitive* p = malloc(sizeof(Primitive));
  p->values = values;

  G_PUSH(p,free_primitive);
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

  return float_equals(w,POINT_W);
}

int is_vector(Primitive* p){
  int w = (p->values)[3];

  return float_equals(w,VECTOR_W);
}

void free_primitive(Primitive* p) {
  free(p->values);
  free(p);

  return;
}

char* to_string(Primitive* p) {
  int BUF_SIZE = PRIMITIVE_SIZE*32;
  char* out = (char*)calloc(1,sizeof(char)*(BUF_SIZE));

  for (int i=0;i<PRIMITIVE_SIZE;i++) {
    if (i != 3) {
      int n = sprintf(out+strlen(out),"%0.2f,",(p->values)[i]);
      if (n < 0) {
        fprintf(stderr,"Error printing Primitive to string.");
        exit(EXIT_FAILURE);
      }
    } else {
      int n = sprintf(out+strlen(out),"%0.2f",(p->values)[i]);
      if (n < 0) {
        fprintf(stderr,"Error printing Primitive to string.");
        exit(EXIT_FAILURE);
      }
    }
  }

  G_PUSH(out,free);
  return out;
}

int primitives_equal(Primitive* a, Primitive* b) {
  int xs = float_equals((a->values)[0],(b->values)[0]);
  int ys = float_equals((a->values)[1],(b->values)[1]);
  int zs = float_equals((a->values)[2],(b->values)[2]);
  int ws = float_equals((a->values)[3],(b->values)[3]);

  return (xs && ys && zs && ws);
}

Primitive* add_primitives(Primitive* a, Primitive* b) {
  float nx = (a->values)[0] + (b->values)[0];
  float ny = (a->values)[1] + (b->values)[1];
  float nz = (a->values)[2] + (b->values)[2];
  float nw = (a->values)[3] + (b->values)[3];

  // Check for error state (point+point)
  if (!float_equals(nw,0) && !float_equals(nw,1)) {
    fprintf(stderr,"Cannot add two points together");
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
  if (!float_equals(nw,0) && !float_equals(nw,1)) {
    fprintf(stderr,"Cannot subtract a point from a vector");
    exit(EXIT_FAILURE);
  }

  return new_primitive(nx,ny,nz,nw);
}

Primitive* scale_primitive(Primitive* p, float s) {
  float nx = (p->values)[0] * s;
  float ny = (p->values)[1] * s;
  float nz = (p->values)[2] * s;
  float nw = (p->values)[3] * s;

  return new_primitive(nx,ny,nz,nw);
}

Primitive* negate_primitive(Primitive* p) {
  return scale_primitive(p,-1);
}

float magnitude_vector(Primitive* p) {
  if (!is_vector(p)) {
    fprintf(stderr,"Can only calculate magnitude of vector");
    exit(EXIT_FAILURE);
  }

  float nx = (p->values)[0];
  float ny = (p->values)[1];
  float nz = (p->values)[2];
  float nw = (p->values)[3];

  return (float)(sqrt((nx*nx)+(ny*ny)+(nz*nz)+(nw*nw)));
}

Primitive* normalize_vector(Primitive* p) {
  if (!is_vector(p)) {
    fprintf(stderr,"Can only normalize vectors");
    exit(EXIT_FAILURE);
  }

  return scale_primitive(p,1/magnitude_vector(p));
}

float dot_vectors(Primitive* a, Primitive* b) {
  float nx = (a->values)[0] * (b->values)[0];
  float ny = (a->values)[1] * (b->values)[1];
  float nz = (a->values)[2] * (b->values)[2];
  float nw = (a->values)[3] * (b->values)[3];

  return (nx + ny + nz + nw);
}

Primitive* cross_vectors(Primitive* a, Primitive* b) {
  float ax = (a->values)[0];
  float ay = (a->values)[1];
  float az = (a->values)[2];
  float bx = (b->values)[0];
  float by = (b->values)[1];
  float bz = (b->values)[2];

  return new_vector(
      (ay*bz) - (az*by),
      (az*bx) - (ax*bz),
      (ax*by) - (ay*bx)
      );
}
