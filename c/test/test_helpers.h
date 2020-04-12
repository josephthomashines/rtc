#ifndef __TEST_HELPERS_H__
#define __TEST_HELPERS_H__

// Easily create a test suite
#define TEST_SUITE(module,tests) \
  Suite* module ## _suite (void) {\
    Suite *suite = suite_create(#module);\
    tests \
    return suite;\
  }

// Easily add a test case to a suite
#define TEST_CASE(test) \
  TCase* test ## _case = tcase_create(#test);\
  tcase_add_test(test ## _case , test);\
  suite_add_tcase(suite, test ## _case);

#endif
