#include <stdlib.h>
#include <stdio.h>

#include "resource.h"

// A pointer to a resource and its destructor
typedef struct Resource {
  void* ptr;
  Dtor* dtor;

  Resource* next;
} Resource;

// A stack of resources
typedef struct ResourceStack {
  Resource* top;
} ResourceStack;

// Create a new resource stack
ResourceStack* new_resource_stack() {
  ResourceStack* rss = (ResourceStack*)calloc(1,sizeof(ResourceStack));
  rss->top = NULL;

  return rss;
}

// Push a resource onto the stack
void push_resource(ResourceStack* rss, void* ptr, Dtor* dtor) {
  Resource* rs = (Resource*)calloc(1,sizeof(Resource));
  rs->ptr = ptr;
  rs->dtor = dtor;
  rs->next = rss->top;

  rss->top = rs;
}

// Destroy and remove and resource from any position in the stack
void destroy_resource(ResourceStack* rss, void* ptr) {
  Resource* curr = rss->top;
  Resource* prev = NULL;
  Resource* next = NULL;

  while (curr != NULL) {
    if (curr->ptr == ptr) {
      curr->dtor(ptr);
      free(curr);
      prev->next = next;
      break;
    }
    prev = curr;
    curr = curr->next;
    next = curr->next;
  }
}

// Update the pointer at any position in the stack
void update_resource(ResourceStack* rss, void* old_ptr, void* new_ptr) {
  Resource* curr = rss->top;

  while (curr != NULL) {
    if (curr->ptr == old_ptr) {
      curr->ptr = new_ptr;
      curr->dtor(old_ptr);
      break;
    }
  }
}

// Destroy the whole stack
void destroy_resource_stack(ResourceStack* rss) {
  Resource* curr = rss->top;
  Resource* next = NULL;

  while (curr != NULL) {
    next = curr->next;
    curr->dtor(curr->ptr);
    free(curr);
    curr = next;
  }

  free(rss);
}

// Initialize global resources
ResourceStack* g_resources = NULL;

// Get the global resources, initialize if NULL
ResourceStack* global_resources() {
  if (!g_resources) {
    g_resources = new_resource_stack();
  }
  return g_resources;
}


