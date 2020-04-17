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
}Color;

// Functions
int colors_equal(Color* a, Color* b);
Color* new_color(float r, float g, float b);
Color* add_colors(Color* a, Color* b);
Color* sub_colors(Color* a, Color* b);
Color* mult_colors(Color* a, Color* b);
Color* scale_color(Color* a, float s);

// Globals
#define BLACK_COLOR \
	new_color(0,0,0);

#endif
