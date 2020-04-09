#ifndef __TEST_PRIMITIVES_H__
#define __TEST_PRIMITIVES_H__

#include <stdio.h>
#include <string.h>
#include <check.h>

#include "primitives.h"
#include "resource.h"

START_TEST (test_new)
{
  Primitive* prim = new_primitive(1,2,3,4);
  ck_assert_msg(prim != NULL, "Primitive should not be NULL");

  Primitive* point = new_point(1,2,3);
  prim = new_primitive(1,2,3,1);
  ck_assert(point != NULL);
  ck_assert(prim != NULL);
  ck_assert_msg(primitivesEqual(point,prim) == 1,
      "\nPrimitives should equal, got %s = %s",toString(point),toString(prim));

  Primitive* vec = new_vector(1,2,3);
  prim = new_primitive(1,2,3,0);
  ck_assert(vec != NULL);
  ck_assert(prim != NULL);
  ck_assert_msg(primitivesEqual(vec,prim) == 1,
      "\nPrimitives should equal, got %s = %s",toString(vec),toString(prim));

  destroy_resource_stack(global_resources());
}
END_TEST

Suite* primitives_suite (void) {
  Suite *suite = suite_create("primitives_suite");
  TCase *tcase = tcase_create("primitives_case");

  tcase_add_test(tcase, test_new);

  suite_add_tcase(suite, tcase);
  return suite;
}

#endif
