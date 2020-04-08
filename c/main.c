
#include <stdio.h>
#include <stdlib.h>

#include "primitives.h"
#include "resource.h"

int main() {
  Primitive* p1 = new_point(1.5,2,3);
  Primitive* p2 = new_vector(4,5,6);

  char* p1Str = toString(p1);
  char* p2Str = toString(p2);
  printf("%s + %s\n",p1Str,p2Str);

  Primitive* sum = add_primitives(p1,p2);
  char* sumStr = toString(sum);
  printf("= %s\n",sumStr);

  destroy_resource_stack(global_resources());
  return 0;
}
