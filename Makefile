
.PHONY: clean build run test fmt

clean:
	rm -rfv raytracer *.ppm *.prof

build:
	go build -o raytracer src/*.go

run:
	make build
	./raytracer

test:
	cd src/ && go test

fmt:
	gofmt -w src/*
