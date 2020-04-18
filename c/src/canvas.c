#include "canvas.h"
#include "resource.h"
#include "util.h"

int colors_equal(Color* a, Color* b) {
	int nr = float_equals(a->r,b->r);
	int ng = float_equals(a->g,b->g);
	int nb = float_equals(a->b,b->b);

	return nr && ng && nb;
}

Color* new_color(float r, float g, float b) {
	Color* c = calloc(1,sizeof(Color));
	c->r = r; c->g = g; c->b = b;

	G_PUSH(c,free); // NOTE: Might be incorrect destructor
	return c;
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

Canvas* new_canvas(int nw, int nh) {
	Canvas* c = calloc(1,sizeof(Canvas));
	c->w = nw; c->h = nh;

	Color*** pixels = calloc(1,sizeof(Color)*nw*nh);
	Color** row = NULL;
	for (int i=0;i<nh;i++) {
		row = calloc(1,sizeof(Color)*nw);
		for (int j=0;j<nw;j++) {
			row[j] = BLACK_COLOR;
		}
		pixels[i] = row;
	}
	c->pixels = pixels;

	G_PUSH(c,free_canvas);
	return c;
}

void free_canvas(Canvas* c) {
	for (int i=0;i<c->h;i++) {
		for (int j=0;j<c->w;j++) {
			G_FREE((c->pixels)[i][j]);
		}
		free((c->pixels)[i]);
	}
	free(c->pixels);
	free(c);
}

void write_pixel(Canvas* c, int row, int col, Color* color) {
	//G_UPDATE((c->pixels)[row][col],color);

	G_FREE((c->pixels)[row][col]);
	(c->pixels)[row][col] = color;
	//G_PUSH((c->pixels)[row][col],free); // NOTE: Might cause double free
}

char* canvas_to_ppm(Canvas* c) {
	char* buf = calloc(1,
			(sizeof(char)*13*c->w*c->h)+64);

	sprintf(buf,"P3\n%d %d\n255\n",c->w,c->h);

	// TODO: Print colors
	//			 TODO: Scale and clip colors to 0-255
	//			 TODO: Wrap lines longer than 70 characters

	// TODO: Ensure the file ends with one new line

	G_PUSH(buf,free)
	return buf;
}

