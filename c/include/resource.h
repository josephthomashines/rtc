#ifndef __RESOURCE_H__
#define __RESOURCE_H__

// Constants

// Types
typedef void (Dtor)(void*);
typedef struct resource_t resource_t;
typedef struct resource_stack_t resource_stack_t;

// Functions
resource_stack_t* new_resource_stack();
void push_resource(resource_stack_t* rss, void* ptr,Dtor* dtor);
void destroy_resource(resource_stack_t* rss, void* ptr);
void update_resource(resource_stack_t* rss, void* old_ptr, void* new_ptr);
void clear_resource_stack(resource_stack_t* rss);
void destroy_resource_stack(resource_stack_t* rss);
resource_stack_t* global_resources();

// Globals
extern resource_stack_t* g_resources;

// Macros for global resource stack
#define G_FREE(ptr) \
  destroy_resource(global_resources(),ptr);

#define G_PUSH(ptr,dtor) \
  push_resource(global_resources(),ptr,dtor);

#define G_UPDATE(old_ptr,new_ptr) \
	update_resource(global_resources(),old_ptr,new_ptr);

#define G_CLEAR_STACK \
  clear_resource_stack(global_resources());

#define G_FREE_STACK \
  destroy_resource_stack(global_resources());

#define G_RETURN \
  destroy_resource_stack(global_resources());\
  return EXIT_SUCCESS;\

#define VERIFY_ALLOC(ptr, type) \
	if (ptr == NULL) {\
		fprintf(stderr, "Could not allocate memory for %s\n", type);\
		G_FREE_STACK;\
		exit(EXIT_FAILURE);\
	}\

#define CHECK_SPRINTF(n,str)\
	if (n < 0) {\
		fprintf(stderr,str);\
		G_FREE_STACK;\
		exit(EXIT_FAILURE);\
	}\

#endif
