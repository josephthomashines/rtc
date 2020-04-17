#include <stdio.h>
#include <check.h>

#include "test_canvas.h"
#include "test_primitives.h"

int main (int argc, char *argv[]) {
  int number_failed;

  #define numSuites 2
  Suite* (*suite_funcs[numSuites])() = {
		canvas_suite,
    primitives_suite,
  };

  for (int i=0;i<numSuites;i++) {
    SRunner *runner = srunner_create((*suite_funcs[i])());

    srunner_run_all(runner, CK_VERBOSE);
    number_failed += srunner_ntests_failed(runner);
    srunner_free(runner);
  }

  return number_failed;
}

