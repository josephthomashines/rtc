#pragma ONCE

#include "utils.h"

typedef T tuple[4];

bool is_point(tuple t);
bool is_vector(tuple t);

tuple *new_point(T x, T y, T z);
tuple *new_vector(T x, T y, T z);

tuple *add_tuples(tuple *a, tuple *b);
tuple *sub_tuples(tuple *a, tuple *b);
T *dot_tuples(tuple *a, tuple *b);
tuple *cross_tuples(tuple *a, tuple *b);

tuple *neg_tuple(tuple *a);
tuple *mul_tuple(tuple *a, T s);
tuple *div_tuple(tuple *a, T s);
tuple *mag_tuple(tuple *a);
tuple *norm_tuple(tuple *a);


