CC=gcc
FLAGS=-g -lm

%: %.c src/*.{c,h}
	$(CC) -o $* $*.c src/*.c $(FLAGS)

main:

test:

# EXEC=./main make val
val:
	valgrind -v --leak-check=full --track-origins=yes --show-leak-kinds=all $(EXEC)
