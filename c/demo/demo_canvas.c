#include "demo_canvas.h"

typedef struct projectile_t {
  primitive_t* position;
  primitive_t* velocity;
} projectile_t;

typedef struct environment_t {
  primitive_t* gravity;
  primitive_t* wind;
} environment_t;

void canvas_demo(char* filename) {
  projectile_t* p = calloc(1,sizeof(projectile_t));
  p->position = new_point(0,1,0);
	primitive_t* tva = new_vector(1,1.8,0);
	primitive_t* tvb = normalize_vector(tva);
  p->velocity = scale_primitive(tvb,11.25);
	free_primitive(tva); free_primitive(tvb);


  environment_t* e = calloc(1,sizeof(environment_t));
  e->gravity = new_vector(0,-0.1,0);
  e->wind = new_vector(-0.01,0,0);


	canvas_t* canvas = new_canvas(900,550);

	int tick_count = 0;
	char* t_pos_str; char* t_vel_str;
	printf("Launching projectile...\n");
  while (primitive_y(p->position) >= 0) {
		t_pos_str = primitive_to_string(p->position);
		t_vel_str = primitive_to_string(p->velocity);
    printf("Position: %25s | Velocity: %25s\n",t_pos_str,t_vel_str);
		free(t_pos_str); free(t_vel_str);

		write_pixel(canvas,550-(int)((p->position->values)[1]),(int)((p->position->values)[0]),new_color(1,1,0));
    tick(e,p);
		tick_count++;
  }

	p->position->values[1] = 0;
	t_pos_str = primitive_to_string(p->position);
	printf("---- Projectile crashed at %s after %d ticks ----\n", t_pos_str, tick_count);
	free(t_pos_str);

	char* outfile = "./demo_canvas.ppm";
	canvas_to_ppm_file(canvas,outfile);

	free_canvas(canvas);
	free_primitive(p->position); free_primitive(p->velocity);
	free_primitive(e->gravity); free_primitive(e->wind);
	free(p); free(e);

	return EXIT_SUCCESS;
}
