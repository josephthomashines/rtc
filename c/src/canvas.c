#include "canvas.h"

#include "util.h"

int colors_equal(color_t* a, color_t* b) {
	int nr = float_equals(a->r,b->r);
	int ng = float_equals(a->g,b->g);
	int nb = float_equals(a->b,b->b);

	return nr && ng && nb;
}

color_t* new_color(float r, float g, float b) {
	color_t* c;
	c = malloc(sizeof(color_t));
	VERIFY_ALLOC(c,"color_t");

	c->r = r; c->g = g; c->b = b;

	return c;
}

void free_color(color_t* c) {free(c);}

color_t* add_colors(color_t* a, color_t* b) {
	float nr = a->r + b->r;
	float ng = a->g + b->g;
	float nb = a->b + b->b;

	return new_color(nr,ng,nb);
}

color_t* sub_colors(color_t* a, color_t* b) {
	float nr = a->r - b->r;
	float ng = a->g - b->g;
	float nb = a->b - b->b;

	return new_color(nr,ng,nb);
}

color_t* mult_colors(color_t* a, color_t* b) {
	float nr = a->r * b->r;
	float ng = a->g * b->g;
	float nb = a->b * b->b;

	return new_color(nr,ng,nb);
}

color_t* scale_color(color_t* a, float s) {
	float nr = a->r * s;
	float ng = a->g * s;
	float nb = a->b * s;

	return new_color(nr,ng,nb);
}

canvas_t* new_canvas(int nw, int nh) {
	canvas_t* c;
	c = malloc(sizeof(canvas_t));
	VERIFY_ALLOC(c,"canvas_t*");

	c->w = nw; c->h = nh;

	color_t*** pixels;
	pixels = calloc(1,sizeof(color_t)*nw*nh);
	VERIFY_ALLOC(pixels,"canvas_t***");

	color_t** row;
	for (int i=0;i<nh;i++) {
		row = calloc(1,sizeof(color_t)*nw);
		VERIFY_ALLOC(row,"canvas_t**");
		for (int j=0;j<nw;j++) {
			row[j] = BLACK_COLOR;
		}
		pixels[i] = row;
	}
	c->pixels = pixels;


	return c;
}

void free_canvas(canvas_t* c) {
	for (int i=0;i<c->h;i++) {
		for (int j=0;j<c->w;j++) {
			if ((c->pixels)[i][j] != NULL) {
				free_color((c->pixels)[i][j]);
			}
		}
		free((c->pixels)[i]);
	}
	free(c->pixels);
	free(c);
}

void write_pixel(canvas_t* c, int row, int col, color_t* color) {
	//G_UPDATE((c->pixels)[row][col],color); // Would like to get this to work

	if ((row >= 0 && row < c->h) &&
			(col >= 0 && col < c->w)) {
		free_color((c->pixels)[row][col]);
		(c->pixels)[row][col] = color;
	}
}

static inline int scale_and_clip_color(float f) {
	int o = (int)(f*255.0);

	if (o > 255) o = 255;
	if (o < 0) o = 0;

	return o;
}

static inline int add_int_to_ppm(char* buf, float value, int row_width, int row_cutoff) {
	if (row_width < (row_cutoff - 8)) {
		int n = sprintf(buf+strlen(buf),"%d ",scale_and_clip_color(value));
		CHECK_SPRINTF(n,"Could not convert canvas to ppm\n");
		return row_width + n;
	} else {
		int n = sprintf(buf+strlen(buf),"%d\n",scale_and_clip_color(value));
		CHECK_SPRINTF(n,"Could not convert canvas to ppm\n");
		return 0;
	}
}

char* canvas_to_ppm(canvas_t* c) {
	// Verify this is the right calculation
	int ALLOC_BYTES = (sizeof(char)*13*c->w*c->h)+16;
	char* buf = calloc(1,ALLOC_BYTES);
	VERIFY_ALLOC(buf,"char*");

	sprintf(buf,"P3\n%d %d\n255\n",c->w,c->h);

	int row_width = 0;
	int row_cutoff = 70;
	for (int i=0;i<c->h;i++) {
		row_width = 0;
		for (int j=0;j<c->w;j++) {
			row_width = add_int_to_ppm(buf,(c->pixels)[i][j]->r,row_width,row_cutoff);
			row_width = add_int_to_ppm(buf,(c->pixels)[i][j]->g,row_width,row_cutoff);
			row_width = add_int_to_ppm(buf,(c->pixels)[i][j]->b,row_width,row_cutoff);
		}
		int n = sprintf(buf+strlen(buf),"\n");
		CHECK_SPRINTF(n,"Could not convert canvas to ppm\n");
	}


	return buf;
}

static inline void fadd_int_to_ppm(char* buf, int* bb_written, float value, int* row_width, int row_cutoff) {
	if ((*row_width) < (row_cutoff - 8)) {
		int n = sprintf(buf+(*bb_written),"%d ",scale_and_clip_color(value));
		CHECK_SPRINTF(n,"Could not convert canvas to ppm\n");
		*bb_written += n;
		*row_width += n;
	} else {
		int n = sprintf(buf+(*bb_written),"%d\n",scale_and_clip_color(value));
		CHECK_SPRINTF(n,"Could not convert canvas to ppm\n");
		*bb_written += n;
		*row_width = 0;
	}
}

void canvas_to_ppm_file(canvas_t* c, char* filename) {
	// Verify this is the right calculation
	int ALLOC_BYTES = 2048;
	char* buf;
	buf = calloc(1,ALLOC_BYTES);
	int n = sprintf(buf,"P3\n%d %d\n255\n",c->w,c->h);
	VERIFY_ALLOC(buf,"char*");

	FILE* fptr;
	fptr = fopen(filename,"w");
	fprintf(stdout,"Opening %s\n",filename);

	if (fptr == NULL) {
		fprintf(stderr,"Error opening %s\n",filename);
		exit(EXIT_FAILURE);
	}

	int row_width = 0;
	int row_cutoff = 30;
	int bb_written = n;
	int fb_written = 0;
	for (int i=0;i<c->h;i++) {
		row_width = 0;
		for (int j=0;j<c->w;j++) {
			fadd_int_to_ppm(buf,&bb_written,(c->pixels)[i][j]->r,&row_width,row_cutoff);
			fadd_int_to_ppm(buf,&bb_written,(c->pixels)[i][j]->g,&row_width,row_cutoff);
			fadd_int_to_ppm(buf,&bb_written,(c->pixels)[i][j]->b,&row_width,row_cutoff);

			if (strlen(buf) > (ALLOC_BYTES - 32)) {
				fseek(fptr,0,fb_written);
				fprintf(fptr,buf);
				fb_written += strlen(buf);
				bb_written = 0;
				memset(buf,0,ALLOC_BYTES);
			}
		}
	}

	fseek(fptr,0,fb_written);
	fprintf(fptr,buf);

	free(buf);
	fclose(fptr);
}

