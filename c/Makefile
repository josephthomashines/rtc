CC=gcc
FLAGS=-g -lm

bin/main: src/* main.c bin
	$(CC) -o bin/main main.c src/*.c $(FLAGS)

bin/test: src/* test.c bin
	$(CC) -o bin/test test.c src/*.c $(FLAGS)

bin:
	mkdir -p bin

clean:
	rm -rfv bin

# EXEC=./main make val
val:
	valgrind -v --leak-check=full --track-origins=yes --show-leak-kinds=all $(EXEC)
