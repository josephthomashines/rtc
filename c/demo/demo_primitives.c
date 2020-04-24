#include "demo_primitives.h"

typedef struct projectile_t {
  primitive_t* position;
  primitive_t* velocity;
} projectile_t;

typedef struct environment_t {
  primitive_t* gravity;
  primitive_t* wind;
} environment_t;

void tick(environment_t* env, projectile_t* proj) {
  proj->position = add_primitives(proj->position,proj->velocity);
  proj->velocity = add_primitives(add_primitives(proj->velocity,env->gravity),env->wind);
}

void primitive_demo(char* filename) {
  projectile_t* p = calloc(1,sizeof(projectile_t));
  p->position = new_point(0,1,0);
  p->velocity = scale_primitive(normalize_vector(new_vector(1,1,0)),1);
  G_PUSH(p,free);

  environment_t* e = calloc(1,sizeof(environment_t));
  e->gravity = new_vector(0,-0.1,0);
  e->wind = new_vector(-0.01,0,0);
  G_PUSH(e,free);

	int tick_count = 0;
	printf("Launching projectile...\n");
  while (primitive_y(p->position) >= 0) {
    printf("Position: %25s | Velocity: %25s\n",to_string(p->position),to_string(p->velocity));
    tick(e,p);
		tick_count++;
  }

	p->position->values[1] = 0;
	printf("---- Crashed at %s after %d ticks ----\n", to_string(p->position),tick_count);

  G_CLEAR_STACK;
}
