#pragma ONCE

#include "utils.h"

typedef struct tuple_t {
	T x;
	T y;
	T z;
	T w;
} tuple;

void print_tuple(tuple *t);

char is_point(tuple *t);
char is_vector(tuple *t);
char tuple_eq(tuple *a, tuple *b);

tuple *new_tuple(T x, T y, T z, T w);
tuple *new_point(T x, T y, T z);
tuple *new_vector(T x, T y, T z);

tuple *add_tuples(tuple *a, tuple *b);
tuple *sub_tuples(tuple *a, tuple *b);
T dot_tuples(tuple *a, tuple *b);
tuple *cross_tuples(tuple *a, tuple *b);

tuple *neg_tuple(tuple *a);
tuple *mul_tuple(tuple *a, T s);
tuple *div_tuple(tuple *a, T s);
T mag_tuple(tuple *a);
tuple *norm_tuple(tuple *a);

int test_tuples();
void demo_tuples();
