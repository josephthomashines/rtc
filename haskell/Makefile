
.PHONY: test clean build run repl

test:
	cabal v2-test --test-show-details='always'

clean:
	cabal v2-clean
	-@rm -rfv *.ppm *.prof *.aux *.hp *.ps cabal.project.local

build:
	cabal v2-build --enable-tests --enable-profiling

run:
	cabal v2-run tracer -- $(ARGS)

prof:
	cabal v2-run --enable-profiling tracer -- $(ARGS) && \
		make graph

graph:
	hp2ps -e8in -c tracer.hp

repl:
	cabal v2-repl

count:
	@echo "Line counts:";
	@bash count.sh demo;
	@bash count.sh exe;
	@bash count.sh src;
	@bash count.sh test;
