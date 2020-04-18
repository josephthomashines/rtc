#ifndef __CANVAS_H__
#define __CANVAS_H__

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

// Constants

// Types
typedef struct Color {
	float r;
	float g;
	float b;
} Color;

typedef struct Canvas {
	int w; int h;
	Color*** pixels;
} Canvas;

// Functions
Color* new_color(float r, float g, float b);
int colors_equal(Color* a, Color* b);
Color* add_colors(Color* a, Color* b);
Color* sub_colors(Color* a, Color* b);
Color* mult_colors(Color* a, Color* b);
Color* scale_color(Color* a, float s);

Canvas* new_canvas(int nw, int nh);
void free_canvas(Canvas* c);
void write_pixel(Canvas* c, int row, int col, Color* color);
char* canvas_to_ppm(Canvas* c);

// Globals
#define BLACK_COLOR \
	new_color(0,0,0)\

#endif
