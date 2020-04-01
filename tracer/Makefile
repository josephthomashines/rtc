
.PHONY: test clean build run repl

test:
	cabal v2-test --test-show-details='always'

clean:
	cabal v2-clean
	-@rm -rfv *.ppm

build:
	cabal v2-build --enable-tests

run:
	cabal v2-run tracer -- $(ARGS)

repl:
	cabal v2-repl

count:
	@echo "Line counts:";
	@bash count.sh demo;
	@bash count.sh exe;
	@bash count.sh src;
	@bash count.sh test;
