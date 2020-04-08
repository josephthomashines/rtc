#ifndef __RESOURCE_H__
#define __RESOURCE_H__

// Constants

// Types
typedef void (Dtor)(void*);
typedef struct Resource Resource;
typedef struct ResourceStack ResourceStack;

// Functions
ResourceStack* new_resource_stack();
void push_resource(ResourceStack* rss, void* ptr,Dtor* dtor);
void destroy_resource(ResourceStack* rss, void* ptr);
void update_resource(ResourceStack* rss, void* old_ptr, void* new_ptr);
void destroy_resource_stack(ResourceStack* rss);
ResourceStack* global_resources();

// Globals
extern ResourceStack* g_resources;

#endif
