#include "canvas.h"
#include "resource.h"
#include "util.h"

Color* new_color(float r, float g, float b) {
	Color* c = calloc(1,sizeof(Color));
	c->r = r; c->g = g; c->b = b;

	G_PUSH(c,free); // WARN: Might be incorrect destructor
	return c;
}

int colors_equal(Color* a, Color* b) {
	int nr = float_equals(a->r,b->r);
	int ng = float_equals(a->g,b->g);
	int nb = float_equals(a->b,b->b);

	return nr && ng && nb;
}

Color* add_colors(Color* a, Color* b) {
	float nr = a->r + b->r;
	float ng = a->g + b->g;
	float nb = a->b + b->b;

	return new_color(nr,ng,nb);
}

Color* sub_colors(Color* a, Color* b) {
	float nr = a->r - b->r;
	float ng = a->g - b->g;
	float nb = a->b - b->b;

	return new_color(nr,ng,nb);
}

Color* mult_colors(Color* a, Color* b) {
	float nr = a->r * b->r;
	float ng = a->g * b->g;
	float nb = a->b * b->b;

	return new_color(nr,ng,nb);
}

Color* scale_color(Color* a, float s) {
	float nr = a->r * s;
	float ng = a->g * s;
	float nb = a->b * s;

	return new_color(nr,ng,nb);
}
