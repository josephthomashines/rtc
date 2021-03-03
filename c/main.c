#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "src/utils.h"

#include "src/tuples.h"

#define MAX_FULL 16

typedef struct opt_t {
	char flag[2];
	char full[MAX_FULL];
	void (*handle)(int, int, char*[]);
} opt;

void handle_demo(int i, int argc, char* argv[])
{

	typedef struct demo_t {
		char* name;
		void (*run)();
	} demo;

#define NUM_DEMOS 1
	demo demos[NUM_DEMOS] = {
		{ "tuple", demo_tuples }
	};

	int error = 1;

	if (i+1 < argc) {
		error = 0;
		int j = 0;
		for (; j < NUM_DEMOS; ++j) {
			if (strncmp(demos[j].name, argv[i+1], 32) == 0) {
				demos[j].run();
				return;
			}
		}
		error = 1;
	}

	if (error) {
		fprintf(stderr, "Unknown demo name, available demos:\n");
		int j = 0;
		for (; j < NUM_DEMOS; ++j) {
			fprintf(stderr, "\t%s", demos[j].name);
		}
		fprintf(stderr, "\n");
		exit(1);
	}
}

#define NUM_OPTS 1
opt opts[NUM_OPTS] = {
	{ "-d", "--demo", handle_demo },
};

char match_opt(opt o, char* s)
{
	return strncmp(o.flag, s, 2) || strncmp(o.full, s, MAX_FULL);
}

int main(int argc, char *argv[])
{
	int i = 1;
	for (; i < argc; ++i) {
		if (argv[i][0] == '-') {
			int j = 0;
			for (; j < NUM_OPTS; ++j) {
				if (match_opt(opts[j], argv[i])) {
					opts[j].handle(i, argc, argv);
					return 0;
				}
			}
		}
	}

	printf("Nothing to do...\n");
	return 0;
}
