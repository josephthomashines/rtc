#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <argp.h>


#include "src/tuples.h"
#include "src/utils.h"


const char *program_version = "rtc 0.0.1";
const char *bug_address = "";

static char doc[] =
	"  ephjos's C implementation of the Raytracer Challenge";

static char args_doc[] =
	"";

static struct argp_option options[] = {
	{ "demo", 'd', "DEMO", 0, "Run the demo named DEMO" },
	{ 0 },
};

struct arguments
{
	bool no_opts;
	char *demo;
};

// Used by parser, call on each opt
static error_t
parse_opt(int key, char *arg, struct argp_state *state)
{
	struct arguments *arguments = state->input;

	switch(key)
	{
		case 'd':
			arguments->no_opts = false;
			arguments->demo = arg;
			break;
		case ARGP_KEY_ARG:
			// ignore all args, only use options
			fprintf(stderr, "ignoring argument: %s\n", arg);
			break;
		case ARGP_KEY_END:
			// If we parse all input and we found no options, print help info and exit
			if (arguments->no_opts == true) {
				fprintf(stderr, "Must provide at least one option...\n\n");
				argp_usage(state);
			}
			break;
		default:
			return ARGP_ERR_UNKNOWN;
	}
	return 0;
}

// Initialize parser
static struct argp argp = { options, parse_opt, args_doc, doc };

// Simple abstraction to allow easily adding demos
struct demo
{
	char *name;
	void (*run)();
};

static struct demo demos[] = {
	{ "tuples", demo_tuples },
};

int
main(int argc, char **argv)
{
	// Initialize arguments
	struct arguments arguments;
	arguments.no_opts = true;
	arguments.demo = NULL;

	// Run arg parser
	argp_parse(&argp, argc, argv, 0, 0, &arguments);

	// Handle running a demo
	if (arguments.demo != NULL) {
		long num_demos = sizeof(demos) / sizeof(struct demo);
		long i = 0;
		for (; i < num_demos; ++i) {
			if (strncmp(arguments.demo, demos[i].name, 32) == 0) {
				demos[i].run();
				exit(0);
			}
		}

		// If argument.demo does not match any known demos, print out all
		// available demos and exit
		i = 0;
		fprintf(stderr, "Unknown demo: %s\n  Available demos: [", arguments.demo);
		for (; i < num_demos; ++i) {
			fprintf(stderr, " %s", demos[i].name);
		}
		fprintf(stderr, " ]\n");
		exit(1);
	}

	exit(0);
}
