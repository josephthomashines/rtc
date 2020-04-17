#ifndef __TEST_CANVAS_H__
#define __TEST_CANVAS_H__

#include <stdio.h>
#include <string.h>
#include <check.h>
#include <math.h>

#include "test_helpers.h"

#include "canvas.h"
#include "resource.h"
#include "util.h"

#define COLORS_EQUAL(a,b) \
	ck_assert(a != NULL);\
	ck_assert(b != NULL);\
	ck_assert(colors_equal(a,b));\

START_TEST (test_new_color) {
	Color* c = new_color(-0.5,0.4,1.7);
	ck_assert_msg(float_equals(c->r,-0.5),"Red is set correctly");
	ck_assert_msg(float_equals(c->g,0.4),"Green is set correctly");
	ck_assert_msg(float_equals(c->b,1.7),"Blue is set correctly");

	G_FREE_STACK;
} END_TEST

START_TEST (test_color_operations) {
	Color* c1 = new_color(0.9,0.6,0.75);
	Color* c2 = new_color(0.7,0.1,0.25);
	Color* c3 = new_color(0.2,0.3,0.4);
	Color* c4 = new_color(1,0.2,0.4);
	Color* c5 = new_color(0.9,1,0.1);
	COLORS_EQUAL(new_color(1.6,0.7,1.0),add_colors(c1,c2));
	COLORS_EQUAL(new_color(0.2,0.5,0.5),sub_colors(c1,c2));
	COLORS_EQUAL(new_color(0.4,0.6,0.8),scale_color(c3,2));
	COLORS_EQUAL(new_color(0.9,0.2,0.04),mult_colors(c4,c5));

	G_FREE_STACK;
} END_TEST

TEST_SUITE(canvas,{
  TEST_CASE(test_new_color);
  TEST_CASE(test_color_operations);
});
#endif
