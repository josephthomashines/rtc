cmake_minimum_required(VERSION 3.1)
project(tracer)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/out")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/")


include_directories(
  "${CMAKE_SOURCE_DIR}/src" ,
  "${CMAKE_SOURCE_DIR}/include" ,
  ${CHECK_INCLUDE_DIRS}
  )

FILE(GLOB SOURCE_FILES src/*.c)
FILE(GLOB SOURCE_HEADERS include/*.h)
add_executable(tracer main.c ${SOURCE_FILES} ${SOURCE_HEADERS})

enable_testing()
find_package(Check REQUIRED)
set(LIBS ${LIBS} ${CHECK_LIBRARIES})
add_executable(test_tracer test/test_tracer.c ${SOURCE_FILES} ${SOURCE_HEADERS})
target_link_libraries(test_tracer ${LIBS})
add_test(test_tracer ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/test_tracer)

install(TARGETS tracer
        DESTINATION ${CMAKE_INSTALL_PREFIX}/bin/)

add_custom_target(clean-all
  make clean && rm -fR ${CMAKE_BINARY_DIR}/CMakeCache.txt
                       ${CMAKE_BINARY_DIR}/cmake_install.cmake
                       ${CMAKE_BINARY_DIR}/Makefile
                       ${CMAKE_BINARY_DIR}/CMakeFiles
                       ${CMAKE_BINARY_DIR}/CTestTestfile.cmake
                       ${CMAKE_BINARY_DIR}/Testing
                       ${CMAKE_BINARY_DIR}/vgcore.*
             && rmdir  ${CMAKE_BINARY_DIR}/out
)
