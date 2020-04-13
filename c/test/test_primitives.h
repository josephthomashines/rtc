#ifndef __TEST_PRIMITIVES_H__
#define __TEST_PRIMITIVES_H__

#include <stdio.h>
#include <string.h>
#include <check.h>
#include <math.h>

#include "test_helpers.h"

#include "primitives.h"
#include "resource.h"
#include "util.h"

// Macros for primitives
#define TEST_TWO_PRIMITIVES(p1,p2) {\
  ck_assert(p1 != NULL);\
  ck_assert(p2 != NULL);\
  ck_assert_msg(primitives_equal(p1,p2) == 1,\
      "\nPrimitives should equal, got %s = %s",to_string(p1),to_string(p2));\
}

START_TEST (test_new) {
  Primitive* point = new_point(4.3,-4.2,3.1);
  Primitive* solution = new_primitive(4.3,-4.2,3.1,1.0);
  TEST_TWO_PRIMITIVES(point,solution);
  ck_assert(is_point(point));

  Primitive* vec = new_vector(4.3,-4.2,3.1);
  solution = new_primitive(4.3,-4.2,3.1,0);
  TEST_TWO_PRIMITIVES(vec,solution);
  ck_assert(is_vector(vec));

  G_FREE_STACK;
} END_TEST

START_TEST (test_operations) {
  Primitive* point = new_point(1,2,3);
  Primitive* vec = new_vector(1,2,3);

  // Addition
  Primitive* pointPlusVec = add_primitives(point,vec);
  Primitive* solution  = new_primitive(2,4,6,1);
  TEST_TWO_PRIMITIVES(pointPlusVec,solution);

  Primitive* vecPlusPoint = add_primitives(vec,point);
  TEST_TWO_PRIMITIVES(vecPlusPoint,solution);

  Primitive* vecPlusVec = add_primitives(vec,vec);
  solution  = new_primitive(2,4,6,0);
  TEST_TWO_PRIMITIVES(vecPlusVec,solution);

  // Subtraction
  Primitive* p1 = new_point(3,2,1);
  Primitive* p2 = new_point(5,6,7);
  Primitive* pointMinusPoint = sub_primitives(p1,p2);
  solution = new_vector(-2,-4,-6);
  TEST_TWO_PRIMITIVES(pointMinusPoint,solution);

  vec = new_vector(5,6,7);
  Primitive* pointMinusVec = sub_primitives(p1,vec);
  solution = new_point(-2,-4,-6);
  TEST_TWO_PRIMITIVES(pointMinusVec,solution);
  G_CLEAR_STACK;

  Primitive* v1 = new_vector(3,2,1);
  Primitive* v2 = new_vector(5,6,7);
  Primitive* vecMinusVec = sub_primitives(v1,v2);
  solution = new_vector(-2,-4,-6);
  TEST_TWO_PRIMITIVES(vecMinusVec,solution);

  // Negation
  Primitive* nv1 = negate_primitive(v1);
  solution = new_vector(-3,-2,-1);
  TEST_TWO_PRIMITIVES(nv1,solution);

  Primitive* bv1 = negate_primitive(nv1);
  TEST_TWO_PRIMITIVES(v1,bv1);
  G_CLEAR_STACK;

  // Scaling
  Primitive* prim = new_primitive(1,-2,3,-4);
  Primitive* sol1 = new_primitive(3.5,-7,10.5,-14);
  Primitive* sol2 = new_primitive(0.5,-1,1.5,-2);
  TEST_TWO_PRIMITIVES(scale_primitive(prim,3.5),sol1);
  TEST_TWO_PRIMITIVES(scale_primitive(prim,0.5),sol2);
  G_CLEAR_STACK;

  // Magnitude
  v1 = new_vector(1,0,0);
  v2 = new_vector(0,1,0);
  Primitive* v3 = new_vector(0,0,1);
  Primitive* v4 = new_vector(1,2,3);
  Primitive* v5 = new_vector(-1,-2,-3);

  ck_assert(float_equals(magnitude_vector(v1),1));
  ck_assert(float_equals(magnitude_vector(v2),1));
  ck_assert(float_equals(magnitude_vector(v3),1));
  ck_assert(float_equals(magnitude_vector(v4),sqrt(14)));
  ck_assert(float_equals(magnitude_vector(v5),sqrt(14)));
  G_CLEAR_STACK;

  // Normalize
  v1 = new_vector(4,0,0);
  v2 = new_vector(1,2,3);
  Primitive* nv2 = normalize_vector(v2);
  sol1 = new_vector(1,0,0);
  sol2 = new_vector(0.26726,0.53452,0.80178);
  TEST_TWO_PRIMITIVES(normalize_vector(v1),sol1);
  TEST_TWO_PRIMITIVES(normalize_vector(v2),sol2);
  ck_assert(float_equals(magnitude_vector(normalize_vector(v1)),1));
  ck_assert(float_equals(magnitude_vector(normalize_vector(v2)),1));
  G_CLEAR_STACK;

  // Dot product
  Primitive* a = new_vector(1,2,3);
  Primitive* b = new_vector(2,3,4);
  ck_assert(float_equals(dot_vectors(a,b),20));

  // Cross product
  sol1 = new_vector(-1,2,-1);
  sol2 = new_vector(1,-2,1);
  TEST_TWO_PRIMITIVES(cross_vectors(a,b),sol1);
  TEST_TWO_PRIMITIVES(cross_vectors(b,a),sol2);

  G_FREE_STACK;
} END_TEST

TEST_SUITE(primitives,{
  TEST_CASE(test_new);
  TEST_CASE(test_operations);
});

#endif
