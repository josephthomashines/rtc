CC=gcc
FLAGS=-g -lm

main: src/* main.c
	$(CC) -o main main.c src/*.c $(FLAGS)

test: src/* test.c
	$(CC) -o test test.c src/*.c $(FLAGS)

# EXEC=./main make val
val:
	valgrind -v --leak-check=full --track-origins=yes --show-leak-kinds=all $(EXEC)
