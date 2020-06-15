
.PHONY: clean build run test fmt

clean:
	rm -rfv raytracer *.ppm *.prof

build:
	go build -o raytracer *.go

run:
	make build
	./raytracer

test:
	go test

fmt:
	gofmt -w .
