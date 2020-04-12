#ifndef __TEST_PRIMITIVES_H__
#define __TEST_PRIMITIVES_H__

#include <stdio.h>
#include <string.h>
#include <check.h>

#include "test_helpers.h"

#include "primitives.h"
#include "resource.h"

// Macros for primitives
#define TEST_TWO_PRIMITIVES(p1,p2) {\
  ck_assert(p1 != NULL);\
  ck_assert(p2 != NULL);\
  ck_assert_msg(primitivesEqual(p1,p2) == 1,\
      "\nPrimitives should equal, got %s = %s",toString(p1),toString(p2));\
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

  Primitive* bv1 = negate_primitive(v1);
  TEST_TWO_PRIMITIVES(v1,bv1);
  G_CLEAR_STACK;

  // Scaling
  // Magnitude
  // Normalize
  // Dot product
  // Cross product

  G_FREE_STACK;
} END_TEST

TEST_SUITE(primitives,{
  TEST_CASE(test_new);
  TEST_CASE(test_operations);
});

#endif
