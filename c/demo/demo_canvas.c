#include "demo_canvas.h"

typedef struct projectile_t {
  primitive_t* position;
  primitive_t* velocity;
} projectile_t;

typedef struct environment_t {
  primitive_t* gravity;
  primitive_t* wind;
} environment_t;

void ctick(environment_t* env, projectile_t* proj) {
	primitive_t* temp_pos = add_primitives(proj->position,proj->velocity);
  primitive_t* temp_vel = add_primitives(add_primitives(proj->velocity,env->gravity),env->wind);

	G_FREE(proj->position);
	G_FREE(proj->velocity);
  proj->position = temp_pos;
  proj->velocity = temp_vel;
}

void canvas_demo(char* filename) {
  projectile_t* p = calloc(1,sizeof(projectile_t));
  p->position = new_point(0,1,0);
  p->velocity = scale_primitive(normalize_vector(new_vector(1,1.8,0)),11.25);
  G_PUSH(p,free);

  environment_t* e = calloc(1,sizeof(environment_t));
  e->gravity = new_vector(0,-0.1,0);
  e->wind = new_vector(-0.01,0,0);
  G_PUSH(e,free);

	canvas_t* canvas = new_canvas(900,550);
	color_t* col = new_color(1,1,0);

	int tick_count = 0;
	printf("Launching projectile...\n");
  while (primitive_y(p->position) >= 0) {
    printf("Position: %25s | Velocity: %25s\n",to_string(p->position),to_string(p->velocity));
		write_pixel(canvas,550-(int)((p->position->values)[1]),(int)((p->position->values)[0]),col);
    ctick(e,p);
		tick_count++;
  }

	p->position->values[1] = 0;
	write_pixel(canvas,550-(int)((p->position->values)[1]),(int)((p->position->values)[0]),col);
	printf("---- Crashed at %s after %d ticks ----\n", to_string(p->position),tick_count);

	char* outfile = "./demo_canvas.ppm";
	canvas_to_ppm_file(canvas,outfile);
	printf("Done 2");

  G_CLEAR_STACK;
}
