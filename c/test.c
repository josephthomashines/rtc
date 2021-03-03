#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include "src/tuples.h"

#define NUM_SUITES 1
int (*tests[NUM_SUITES])() =
{
	test_tuples,
};


int main(int argc, char *argv[])
{
	printf("Testing...\n");

	int i = 0, test_count = 0;
	for (; i < NUM_SUITES; ++i) {
		test_count += (*tests[i])();
	}

	printf("All tests passed!\n");
	printf("\t%d suite(s) ran %d test(s).\n", NUM_SUITES, test_count);
	return 0;
}
