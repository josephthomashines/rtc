cmake_minimum_required(VERSION 3.1)
project(helloworld C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/out")

include_directories(
  "${CMAKE_SOURCE_DIR}/src",
  "${CMAKE_SOURCE_DIR}/include"
  )

FILE(GLOB SOURCE_FILES src/*.c)
FILE(GLOB SOURCE_HEADERS include/*.h)
add_executable(tracer main.c ${SOURCE_FILES} ${SOURCE_HEADERS})

FILE(GLOB TEST_SOURCE_FILES test/*.c)
add_executable(test_tracer ${TEST_SOURCE_FILES} ${SOURCE_FILES} ${SOURCE_HEADERS})

install(TARGETS tracer
        DESTINATION ${CMAKE_INSTALL_PREFIX}/bin/)

add_custom_target(clean-all
  make clean && rm -fR ${CMAKE_BINARY_DIR}/CMakeCache.txt
                       ${CMAKE_BINARY_DIR}/cmake_install.cmake
                       ${CMAKE_BINARY_DIR}/Makefile
                       ${CMAKE_BINARY_DIR}/CMakeFiles
             && rmdir  ${CMAKE_BINARY_DIR}/out
)
