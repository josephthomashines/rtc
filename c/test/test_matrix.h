#ifndef __TEST_MATRIX_H__
#define __TEST_MATRIX_H__

#include <stdio.h>
#include <string.h>
#include <check.h>
#include <math.h>

#include "test_helpers.h"

#include "matrix.h"
#include "util.h"

START_TEST(test_new_matrix) {
	matrix_t* m = new_matrix(4,4);

	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			ck_assert_msg((m->v)[i][j] == 0,
					"New matrix not all 0's\n");
		}
	}
	free_matrix(m);

	matrix_t* a = new_matrix(4,4);
	(a->v)[0][0] = 1; (a->v)[0][1] = 2; (a->v)[0][2] = 3; (a->v)[0][3] = 4;
	(a->v)[1][0] = 5.5; (a->v)[1][1] = 6.5; (a->v)[1][2] = 7.5; (a->v)[1][3] = 8.5;
	(a->v)[2][0] = 9; (a->v)[2][1] = 10; (a->v)[2][2] = 11; (a->v)[2][3] = 12;
	(a->v)[3][0] = 13.5; (a->v)[3][1] = 14.5; (a->v)[3][2] = 15.5; (a->v)[3][3] = 16.5;

	ck_assert((a->v)[0][0]==1);
	ck_assert((a->v)[0][3]==4);
	ck_assert((a->v)[1][0]==5.5);
	ck_assert((a->v)[1][2]==7.5);
	ck_assert((a->v)[2][2]==11);
	ck_assert((a->v)[3][0]==13.5);
	ck_assert((a->v)[3][2]==15.5);

	free_matrix(a);
} END_TEST

START_TEST(test_matrix_operations) {
	matrix_t* m = new_matrix(4,4);
	(m->v)[0][0] = 1; (m->v)[0][1] = 2; (m->v)[0][2] = 3; (m->v)[0][3] = 4;
	(m->v)[1][0] = 5; (m->v)[1][1] = 6; (m->v)[1][2] = 7; (m->v)[1][3] = 8;
	(m->v)[2][0] = 9; (m->v)[2][1] = 8; (m->v)[2][2] = 7; (m->v)[2][3] = 6;
	(m->v)[3][0] = 5; (m->v)[3][1] = 4; (m->v)[3][2] = 3; (m->v)[3][3] = 2;

	ck_assert(matrix_equals(m,m));
	matrix_t* a = new_matrix(4,4);
	ck_assert(matrix_equals(m,a)==0);
	matrix_t* b = new_matrix(4,3);
	ck_assert(matrix_equals(m,b)==0);
	free_matrix(a);
	free_matrix(b);

} END_TEST

TEST_SUITE(matrix,{
		TEST_CASE(test_new_matrix);
		TEST_CASE(test_matrix_operations);
});
#endif
