#include <stdlib.h>
#include <stdio.h>

#include "resource.h"

// A pointer to a resource and its destructor
typedef struct resource_t {
  void* ptr;
  Dtor* dtor;

  resource_t* next;
} resource_t;

// A stack of resources
typedef struct resource_stack_t {
  resource_t* top;
} resource_stack_t;

// Create a new resource stack
resource_stack_t* new_resource_stack() {
  resource_stack_t* rss = calloc(1,sizeof(resource_stack_t));
  rss->top = NULL;

  return rss;
}

// Push a resource onto the stack
void push_resource(resource_stack_t* rss, void* ptr, Dtor* dtor) {
  resource_t* rs = calloc(1,sizeof(resource_t));
  rs->ptr = ptr;
  rs->dtor = dtor;
  rs->next = rss->top;

  rss->top = rs;
}

// Destroy and remove and resource from any position in the stack
void destroy_resource(resource_stack_t* rss, void* ptr) {
  resource_t* curr = rss->top;
  resource_t* prev = NULL;
  resource_t* next = NULL;

  while (curr != NULL) {
    if (curr->ptr == ptr) {
      curr->dtor(ptr);
      free(curr);
      if (prev != NULL) {
        prev->next = next;
      }
      rss->top = NULL;
      break;
    }
    prev = curr;
    curr = curr->next;
    next = curr->next;
  }
}

// Update the pointer at any position in the stack
void update_resource(resource_stack_t* rss, void* old_ptr, void* new_ptr) {
  resource_t* curr = rss->top;

  while (curr != NULL) {
    if (curr->ptr == old_ptr) {
      curr->dtor(curr->ptr);
      curr->ptr = new_ptr;

			return;
    }
		curr = curr->next;
  }

	fprintf(stderr,
			"Could not find ptr on stack, are you sure its already been allocated?");
	exit(EXIT_FAILURE);
}

// Clear the whole stack
void clear_resource_stack(resource_stack_t* rss) {
  if (rss != NULL) {
    resource_t* curr = rss->top;
    resource_t* next = NULL;

    while (curr != NULL) {
      next = curr->next;
			if (curr->ptr != NULL) {
				curr->dtor(curr->ptr);
			}
      free(curr);
      curr = next;
    }
  }

  rss->top = NULL;
}

// Destroy the whole stack
void destroy_resource_stack(resource_stack_t* rss) {
  clear_resource_stack(rss);
  free(rss);
}

// Initialize global resources
resource_stack_t* g_resources = NULL;

// Get the global resources, initialize if NULL
resource_stack_t* global_resources() {
  if (g_resources == NULL) {
    g_resources = new_resource_stack();
  }
  return g_resources;
}


