#include "canvas.h"
#include "resource.h"
#include "util.h"

int colors_equal(color_t* a, color_t* b) {
	int nr = float_equals(a->r,b->r);
	int ng = float_equals(a->g,b->g);
	int nb = float_equals(a->b,b->b);

	return nr && ng && nb;
}

color_t* new_color(float r, float g, float b) {
	color_t* c;
	c = malloc(sizeof(color_t));
	VERIFY_ALLOC(c,"color_t");

	c->r = r; c->g = g; c->b = b;

	G_PUSH(c,free); // NOTE: Might be incorrect destructor
	return c;
}

color_t* add_colors(color_t* a, color_t* b) {
	float nr = a->r + b->r;
	float ng = a->g + b->g;
	float nb = a->b + b->b;

	return new_color(nr,ng,nb);
}

color_t* sub_colors(color_t* a, color_t* b) {
	float nr = a->r - b->r;
	float ng = a->g - b->g;
	float nb = a->b - b->b;

	return new_color(nr,ng,nb);
}

color_t* mult_colors(color_t* a, color_t* b) {
	float nr = a->r * b->r;
	float ng = a->g * b->g;
	float nb = a->b * b->b;

	return new_color(nr,ng,nb);
}

color_t* scale_color(color_t* a, float s) {
	float nr = a->r * s;
	float ng = a->g * s;
	float nb = a->b * s;

	return new_color(nr,ng,nb);
}

canvas_t* new_canvas(int nw, int nh) {
	canvas_t* c;
	c = malloc(sizeof(canvas_t));
	VERIFY_ALLOC(c,"canvas_t*");

	c->w = nw; c->h = nh;

	color_t*** pixels;
	pixels = calloc(1,sizeof(color_t)*nw*nh);
	VERIFY_ALLOC(pixels,"canvas_t***");

	color_t** row;
	for (int i=0;i<nh;i++) {
		row = calloc(1,sizeof(color_t)*nw);
		VERIFY_ALLOC(row,"canvas_t**");
		for (int j=0;j<nw;j++) {
			row[j] = BLACK_COLOR;
		}
		pixels[i] = row;
	}
	c->pixels = pixels;

	G_PUSH(c,free_canvas);
	return c;
}

void free_canvas(canvas_t* c) {
	for (int i=0;i<c->h;i++) {
		for (int j=0;j<c->w;j++) {
			if ((c->pixels)[i][j] != NULL) {
				G_FREE((c->pixels)[i][j]);
			}
		}
		free((c->pixels)[i]);
	}
	free(c->pixels);
	free(c);
}

void write_pixel(canvas_t* c, int row, int col, color_t* color) {
	//G_UPDATE((c->pixels)[row][col],color); // Would like to get this to work

	G_FREE((c->pixels)[row][col]);
	(c->pixels)[row][col] = color;
}

char* canvas_to_ppm(canvas_t* c) {
	char* buf = calloc(1,
			(sizeof(char)*13*c->w*c->h)+64); // Verify this is the right calculation
	VERIFY_ALLOC(buf,"char*");

	sprintf(buf,"P3\n%d %d\n255\n",c->w,c->h);

	// TODO: Print colors
	//       TODO: Scale and clip colors to 0-255
	//       TODO: Wrap lines longer than 70 characters

	// TODO: Ensure the file ends with one new line

	G_PUSH(buf,free)
	return buf;
}

