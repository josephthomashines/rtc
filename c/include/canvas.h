#ifndef __CANVAS_H__
#define __CANVAS_H__

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

// Constants

// Types
typedef struct color_t {
	float r;
	float g;
	float b;
} color_t;

typedef struct canvas_t {
	int w; int h;
	color_t*** pixels;
} canvas_t;

// Functions
color_t* new_color(float r, float g, float b);
int colors_equal(color_t* a, color_t* b);
color_t* add_colors(color_t* a, color_t* b);
color_t* sub_colors(color_t* a, color_t* b);
color_t* mult_colors(color_t* a, color_t* b);
color_t* scale_color(color_t* a, float s);

canvas_t* new_canvas(int nw, int nh);
void free_canvas(canvas_t* c);
void write_pixel(canvas_t* c, int row, int col, color_t* color);
char* canvas_to_ppm(canvas_t* c);

// Globals
#define BLACK_COLOR \
	new_color(0,0,0)\

#endif
