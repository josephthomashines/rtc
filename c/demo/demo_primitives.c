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
	primitive_t* temp_pos = add_primitives(proj->position,proj->velocity);
	primitive_t* temp_vg = add_primitives(proj->velocity,env->gravity);
  primitive_t* temp_vel = add_primitives(temp_vg,env->wind);

	free_primitive(proj->position);
	free_primitive(temp_vg);
	free_primitive(proj->velocity);

  proj->position = temp_pos;
  proj->velocity = temp_vel;
}

void primitive_demo(char* filename) {
  projectile_t* p = calloc(1,sizeof(projectile_t));
  p->position = new_point(0,1,0);
	primitive_t* tva = new_vector(1,1,0);
	primitive_t* tvb = normalize_vector(tva);
  p->velocity = scale_primitive(tvb,1);
	free_primitive(tva); free_primitive(tvb);

  environment_t* e = calloc(1,sizeof(environment_t));
  e->gravity = new_vector(0,-0.1,0);
  e->wind = new_vector(-0.01,0,0);

	int tick_count = 0;
	char* t_pos_str; char* t_vel_str;
	printf("Launching projectile...\n");
  while (primitive_y(p->position) >= 0) {
		t_pos_str = to_string(p->position);
		t_vel_str = to_string(p->velocity);
    printf("Position: %25s | Velocity: %25s\n",t_pos_str,t_vel_str);
		free(t_pos_str); free(t_vel_str);
    tick(e,p);
		tick_count++;
  }

	p->position->values[1] = 0;
	t_pos_str = to_string(p->position);
	printf("---- Projectile crashed at %s after %d ticks ----\n", t_pos_str, tick_count);
	free(t_pos_str);

	free_primitive(p->position); free_primitive(p->velocity);
	free_primitive(e->gravity); free_primitive(e->wind);
	free(p); free(e);

	return EXIT_SUCCESS;
}
