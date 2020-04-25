
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "demo_canvas.h"
#include "demo_primitives.h"

#define COMMAND(NAME)  { #NAME, NAME ## _demo }

struct command {
	char *name;
	void (*function) (char*);
};

#define NUM_COMMANDS 2
struct command commands[NUM_COMMANDS] = {
	COMMAND (canvas),
	COMMAND (primitive),
};

void print_help() {
	printf("C Ray Tracer v0.0.1\n");
	printf("\t-h\t\tshow this menu\n");
	printf("\t-f FILE\t\tpass a filename for commands that use it\n");
	printf("\t-d DEMO\t\tspecify a demo to run\n");
	printf("\t\t\tcanvas\n");
	printf("\t\t\tprimitive\n");
	//printf("\t \t\t \n");
}

int main(int argc, char* argv[]) {
	int opt;
	char filename[64];
	char demo[64];
	int isDemo = 0;

	while((opt = getopt(argc, argv, ":f:d:h")) != -1) {
			switch(opt) {
					case 'f':
							strcpy(filename,optarg);
							break;
					case 'd':
							strcpy(demo,optarg);
							isDemo = 1;
							break;
					case 'h':
							print_help();
							return EXIT_SUCCESS;
					case '?':
					default:
							fprintf(stderr,"unknown option: %c\n", optopt);
							break;
			}
	}

	if (isDemo) {
		for (int i=0;i<NUM_COMMANDS;i++) {
			if (strcmp(commands[i].name,demo) == 0) {
				commands[i].function(filename);
				return EXIT_SUCCESS;
			}
		}
		fprintf(stderr,"unknown demo: %s\n", demo);
		print_help();
		return EXIT_FAILURE;
	}

	print_help();
	return EXIT_SUCCESS;
}
