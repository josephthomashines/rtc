
.PHONY: test clean build run repl

test:
	cabal v2-test --test-show-details='always'

clean:
	cabal clean
	cabal v2-clean

build:
	cabal v2-build

run:
	cabal v2-run tracer

repl:
	cabal v2-repl
