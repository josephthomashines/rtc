# C Ray Tracer

## Requirements

- gcc
- cmake
- [libcheck](https://libcheck.github.io/check/web/install.html)
- ctest

## To build

```shell
cmake .
make
```

This produces 2 executables in the `out/` directory.
`out/tracer` is the main executable which can be ran to
produce ?
Running `ctest` will find the `out/test_tracer` executable
and run the tests

## Developers

If you have the `inotifytools` package installed,
the provided `monitor` shell script will watch the
source files and recompile whenever a file is changed.

