#include "matrix.h"

matrix_t* new_matrix(int w, int h){
	matrix_t* m = calloc(1,sizeof(matrix_t));
	m->w = w; m->h = h;

	float** v = malloc(h);
	for(int i=0;i<h;i++){
		v[i] = malloc(w);
	}

	for(int i=0;i<h;i++){
		for(int j=0;j<w;j++){
			v[i][j] = 0;
		}
	}

	m->v = v;
	return m;
}

char* matrix_to_string(matrix_t* m){
	char* buf = malloc(m->w * m->h * 15);
	int written = 0;

	for(int i=0;i<m->h;i++){
		for(int j=0;j<m->w;j++){
			int n = sprintf(buf+written, "%10.4f ",(m->v)[i][j]);
			CHECK_SPRINTF(n,"Could not write matrix to string\n");
			written+=n;
		}
		int n = sprintf(buf+written, "\n");
		CHECK_SPRINTF(n,"Could not write matrix to string\n");
		written+=n;
	}

	return buf;
}

void free_matrix(matrix_t* m){
	fprintf(stderr,"A\n");
	for(int i=0;i<m->h;i++){
		fprintf(stderr,"B\n");
		free((m->v[i]));
	}
	fprintf(stderr,"C\n");
	free(m->v);
	fprintf(stderr,"D\n");
	free(m);
}

int matrix_equals(matrix_t* a, matrix_t* b){
	if(a->w != b->w || a->h != b->h)
		return 0;

	for(int i=0;i<a->h;i++){
		for(int j=0;j<a->w;j++){
			if(!float_equals((a->v)[i][j],(b->v)[i][j]))
				return 0;
		}
	}
	return 1;
}
