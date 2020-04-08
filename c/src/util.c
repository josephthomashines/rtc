#include <stdlib.h>
#include <stdio.h>

#include "util.h"

int floatEquals(float a, float b) {
  const int epsilon = 1E-4;
  return (fabs(a - b) <= epsilon * fabs(a));
}
