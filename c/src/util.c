#include "util.h"

int float_equals(float a, float b) {
  const float epsilon = 1E-4;
  return (fabs(a - b) <= epsilon * fabs(a));
}
