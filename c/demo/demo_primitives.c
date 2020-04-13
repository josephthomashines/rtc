#include "demo_primitives.h"

typedef struct Projectile {
  Primitive* position;
  Primitive* velocity;
} Projectile;

typedef struct Environment {
  Primitive* gravity;
  Primitive* wind;
} Environment;

void tick(Environment* env, Projectile* proj) {
  proj->position = add_primitives(proj->position,proj->velocity);
  proj->velocity = add_primitives(add_primitives(proj->velocity,env->gravity),env->wind);
}

void primitive_demo(char* filename) {
  Projectile* p = calloc(1,sizeof(Projectile));
  p->position = new_point(0,1,0);
  p->velocity = scale_primitive(normalize_vector(new_vector(1,1,0)),1);
  G_PUSH(p,free);

  Environment* e = calloc(1,sizeof(Environment));
  e->gravity = new_vector(0,-0.1,0);
  e->wind = new_vector(-0.01,0,0);
  G_PUSH(e,free);

  while (primitive_y(p->position) >= 0) {
    printf("Pos: %25s | Vel: %25s\n",to_string(p->position),to_string(p->velocity));
    tick(e,p);
  }

  G_CLEAR_STACK;
}
