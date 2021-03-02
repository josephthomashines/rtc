#pragma ONCE

#define T double

#define ERR( fmt, ... ) \
	do { \
		fprintf(stderr, fmt, ##__VA_ARGS__); \
		exit(1); \
	} while (0)

#undef MAX
#define MAX( a, b ) ((a) > (b) ? (a) : (b))

#undef MIN
#define MIN( a, b ) ((a) > (b) ? (b) : (a))

#define IS_BETWEEN( x, a, b ) \
	((unsigned char)((x) >= (a) && (x) <= (b)))

#undef ABS
#define ABS( x ) (((x) < 0) ? (-(x)) : (x))

#define EQ( a, b ) ((ABS((a-b))) < 0.0001)

#define CLIP( x, a, b ) \
	(IS_BETWEEN((x), (a), (b)) ? (x) : (x) < (a) ? (a) : (b))

