
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "primitives.h"
#include "resource.h"

int main(int argc, char* argv[]) {
  int opt;
  char filename[64];

  while((opt = getopt(argc, argv, ":f:d:")) != -1) {
      switch(opt) {
          case 'f':
              strcpy(filename,optarg);
              break;
          case 'd':
              printf("Demo %s\n",optarg);
              break;
          case '?':
              fprintf(stderr,"unknown option: %c\n", optopt);
              break;
      }
  }

  // optind is for the extra arguments
  // which are not parsed
  /*for(; optind < argc; optind++) {
      printf("extra arguments: %s\n", argv[optind]);
  }*/

  return 0;
}
