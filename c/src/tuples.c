#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "tuples.h"

void print_tuple(tuple *t)
{
	printf("[%6.3f, %6.3f, %6.3f, %6.3f]\n", t->x, t->y, t->z, t->w);
}

char is_point(tuple *t)
{
	return EQ(t->w, 1.0);
}

char is_vector(tuple *t)
{
	return EQ(t->w, 0.0);
}

char tuple_eq(tuple *a, tuple *b)
{
	return EQ(a->x, b->x) && EQ(a->y, b->y) && EQ(a->z, b->z) && EQ(a->w, b->w);
}

tuple *new_tuple(T x, T y, T z, T w)
{
	tuple* res = malloc(sizeof(tuple));
	res->x = x;
	res->y = y;
	res->z = z;
	res->w = w;
	return res;
}

tuple *new_point(T x, T y, T z)
{
	return new_tuple(x, y, z, 1.0);
}

tuple *new_vector(T x, T y, T z)
{
	return new_tuple(x, y, z, 0.0);
}

tuple *add_tuples(tuple *a, tuple *b)
{
	assert(is_vector(a) || is_vector(b));
	return new_tuple(
			a->x + b->x,
			a->y + b->y,
			a->z + b->z,
			a->w + b->w
	);
}

tuple *sub_tuples(tuple *a, tuple *b)
{
	if (is_vector(a)) {
		assert(is_vector(b));
	}
	return new_tuple(
			a->x - b->x,
			a->y - b->y,
			a->z - b->z,
			a->w - b->w
	);
}

T dot_tuples(tuple *a, tuple *b)
{
	return (a->x*b->x) + (a->y*b->y) + (a->z*b->z) + (a->w*b->w);
}

tuple *cross_tuples(tuple *a, tuple *b)
{
	return new_vector(
			a->y*b->z - a->z*b->y,
			a->z*b->x - a->x*b->z,
			a->x*b->y - a->y*b->x
	);
}

tuple *neg_tuple(tuple *a)
{
	return new_tuple(-1*a->x, -1*a->y, -1*a->z, -1*a->w);
}

tuple *mul_tuple(tuple *a, T s)
{
	return new_tuple(s*a->x, s*a->y, s*a->z, s*a->w);
}

tuple *div_tuple(tuple *a, T s)
{
	return mul_tuple(a, 1.0/s);
}

T mag_tuple(tuple *a)
{
	return sqrt(dot_tuples(a, a));
}

tuple *norm_tuple(tuple *a)
{
	return div_tuple(a, mag_tuple(a));
}

int test_tuples()
{
	START_TESTS();
	tuple *a = new_tuple(4.3, -4.2, 3.1, 1.0);
	ASSERT(EQ(a->x,4.3));
	ASSERT(EQ(a->y,-4.2));
	ASSERT(EQ(a->z,3.1));
	ASSERT(EQ(a->w,1.0));
	ASSERT(is_point(a));
	ASSERT(!is_vector(a));
	free(a);

	a = new_tuple(4.3, -4.2, 3.1, 0.0);
	ASSERT(EQ(a->x,4.3));
	ASSERT(EQ(a->y,-4.2));
	ASSERT(EQ(a->z,3.1));
	ASSERT(EQ(a->w,0.0));
	ASSERT(!is_point(a));
	ASSERT(is_vector(a));
	free(a);

	a = new_point(4, -4, 3);
	ASSERT(EQ(a->x,4));
	ASSERT(EQ(a->y,-4));
	ASSERT(EQ(a->z,3));
	ASSERT(EQ(a->w,1.0));
	ASSERT(is_point(a));
	ASSERT(!is_vector(a));
	free(a);

	a = new_vector(4, -4, 3);
	ASSERT(EQ(a->x,4));
	ASSERT(EQ(a->y,-4));
	ASSERT(EQ(a->z,3));
	ASSERT(EQ(a->w,0.0));
	ASSERT(!is_point(a));
	ASSERT(is_vector(a));
	free(a);

	tuple *a1 = new_tuple(3, -2, 5, 1);
	tuple *a2 = new_tuple(-2, 3, 1, 0);
	tuple *exp = new_tuple(1, 1, 6, 1);
	tuple *res = add_tuples(a1, a2);
	ASSERT(tuple_eq(exp, res));
	free(a1); free(a2); free(exp); free(res);

	tuple* p1 = new_point(3, 2, 1);
	tuple* p2 = new_point(5, 6, 7);
	exp = new_vector(-2, -4, -6);
	res = sub_tuples(p1, p2);
	ASSERT(tuple_eq(exp, res));
	free(p1); free(p2); free(exp); free(res);

	tuple *p = new_point(3, 2, 1);
	tuple *v = new_vector(5, 6, 7);
	exp = new_point(-2, -4, -6);
	res = sub_tuples(p, v);
	ASSERT(tuple_eq(exp, res));
	free(p); free(v); free(exp); free(res);

	tuple *v1 = new_vector(3, 2, 1);
	tuple *v2 = new_vector(5, 6, 7);
	exp = new_vector(-2, -4, -6);
	res = sub_tuples(v1, v2);
	ASSERT(tuple_eq(exp, res));
	free(v1); free(v2); free(exp); free(res);

	a = new_tuple(1, -2, 3, -4);
	exp = new_tuple(-1, 2, -3, 4);
	res = neg_tuple(a);
	ASSERT(tuple_eq(exp, res));
	free(a); free(exp); free(res);

	a = new_tuple(1, -2, 3, -4);
	exp = new_tuple(3.5, -7, 10.5, -14);
	res = mul_tuple(a, 3.5);
	ASSERT(tuple_eq(exp, res));
	free(a); free(exp); free(res);

	a = new_tuple(1, -2, 3, -4);
	exp = new_tuple(0.5, -1, 1.5, -2);
	res = mul_tuple(a, 0.5);
	ASSERT(tuple_eq(exp, res));
	free(a); free(exp); free(res);

	a = new_tuple(1, -2, 3, -4);
	exp = new_tuple(0.5, -1, 1.5, -2);
	res = div_tuple(a, 2);
	ASSERT(tuple_eq(exp, res));
	free(a); free(exp); free(res);

	v = new_vector(1, 0, 0);
	ASSERT(EQ(1.0, mag_tuple(v)));
	free(v);

	v = new_vector(0, 1, 0);
	ASSERT(EQ(1.0, mag_tuple(v)));
	free(v);

	v = new_vector(0, 0, 1);
	ASSERT(EQ(1.0, mag_tuple(v)));
	free(v);

	v = new_vector(1, 2, 3);
	ASSERT(EQ(sqrt(14), mag_tuple(v)));
	free(v);

	v = new_vector(-1, -2, -3);
	ASSERT(EQ(sqrt(14), mag_tuple(v)));
	free(v);

	v = new_vector(4, 0, 0);
	exp = new_vector(1, 0, 0);
	res = norm_tuple(v);
	ASSERT(tuple_eq(exp, res));
	free(v); free(exp); free(res);

	v = new_vector(1, 2, 3);
	exp = new_vector(0.26726, 0.53452, 0.80178);
	res = norm_tuple(v);
	ASSERT(tuple_eq(exp, res));
	free(v); free(exp); free(res);

	v = new_vector(1, 2, 3);
	res = norm_tuple(v);
	ASSERT(EQ(1.0, mag_tuple(res)));
	free(v); free(res);

	a = new_vector(1, 2, 3);
	tuple *b = new_vector(2, 3, 4);
	ASSERT(EQ(20.0, dot_tuples(a, b)));

	exp = new_vector(-1, 2, -1);
	res = cross_tuples(a, b);
	ASSERT(tuple_eq(exp, res));
	free(exp); free(res);

	exp = new_vector(1, -2, 1);
	res = cross_tuples(b, a);
	ASSERT(tuple_eq(exp, res));
	free(exp); free(res);
	free(a); free(b);

	return TEST_COUNT;
}

typedef struct proj_t {
	tuple *pos;
	tuple *vel;
} proj;

typedef struct env_t {
	tuple *gravity;
	tuple *wind;
} env;

proj tick(env e, proj p)
{
	tuple *env_impact = add_tuples(e.gravity, e.wind);
	proj res = {
		add_tuples(p.pos, p.vel),
		add_tuples(p.vel, env_impact)
	};
	free(env_impact);
	return res;
}

void demo_tuples()
{
	tuple *vel = new_vector(1, 1, 0);
	proj p = { new_point(0, 1, 0), norm_tuple(vel) };
	free(vel);

	env e = { new_vector(0, -0.1, 0), new_vector(-0.01, 0, 0) };

	proj np;
	while (p.pos->y > 0) {
		print_tuple(p.pos);
		np = tick(e, p);
		free(p.pos); free(p.vel);
		p = np;
	}
	p.pos->y = 0;
	print_tuple(p.pos);
	free(p.pos); free(p.vel);
	free(e.gravity); free(e.wind);
}
