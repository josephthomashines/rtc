# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/joseph/repos/rtc/c

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/joseph/repos/rtc/c

# Include any dependencies generated for this target.
include CMakeFiles/tracer.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/tracer.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/tracer.dir/flags.make

CMakeFiles/tracer.dir/main.c.o: CMakeFiles/tracer.dir/flags.make
CMakeFiles/tracer.dir/main.c.o: main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joseph/repos/rtc/c/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/tracer.dir/main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/tracer.dir/main.c.o   -c /home/joseph/repos/rtc/c/main.c

CMakeFiles/tracer.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/tracer.dir/main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/joseph/repos/rtc/c/main.c > CMakeFiles/tracer.dir/main.c.i

CMakeFiles/tracer.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/tracer.dir/main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/joseph/repos/rtc/c/main.c -o CMakeFiles/tracer.dir/main.c.s

CMakeFiles/tracer.dir/src/primitives.c.o: CMakeFiles/tracer.dir/flags.make
CMakeFiles/tracer.dir/src/primitives.c.o: src/primitives.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joseph/repos/rtc/c/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/tracer.dir/src/primitives.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/tracer.dir/src/primitives.c.o   -c /home/joseph/repos/rtc/c/src/primitives.c

CMakeFiles/tracer.dir/src/primitives.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/tracer.dir/src/primitives.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/joseph/repos/rtc/c/src/primitives.c > CMakeFiles/tracer.dir/src/primitives.c.i

CMakeFiles/tracer.dir/src/primitives.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/tracer.dir/src/primitives.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/joseph/repos/rtc/c/src/primitives.c -o CMakeFiles/tracer.dir/src/primitives.c.s

CMakeFiles/tracer.dir/src/say_hello.c.o: CMakeFiles/tracer.dir/flags.make
CMakeFiles/tracer.dir/src/say_hello.c.o: src/say_hello.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joseph/repos/rtc/c/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/tracer.dir/src/say_hello.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/tracer.dir/src/say_hello.c.o   -c /home/joseph/repos/rtc/c/src/say_hello.c

CMakeFiles/tracer.dir/src/say_hello.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/tracer.dir/src/say_hello.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/joseph/repos/rtc/c/src/say_hello.c > CMakeFiles/tracer.dir/src/say_hello.c.i

CMakeFiles/tracer.dir/src/say_hello.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/tracer.dir/src/say_hello.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/joseph/repos/rtc/c/src/say_hello.c -o CMakeFiles/tracer.dir/src/say_hello.c.s

# Object files for target tracer
tracer_OBJECTS = \
"CMakeFiles/tracer.dir/main.c.o" \
"CMakeFiles/tracer.dir/src/primitives.c.o" \
"CMakeFiles/tracer.dir/src/say_hello.c.o"

# External object files for target tracer
tracer_EXTERNAL_OBJECTS =

out/tracer: CMakeFiles/tracer.dir/main.c.o
out/tracer: CMakeFiles/tracer.dir/src/primitives.c.o
out/tracer: CMakeFiles/tracer.dir/src/say_hello.c.o
out/tracer: CMakeFiles/tracer.dir/build.make
out/tracer: CMakeFiles/tracer.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/joseph/repos/rtc/c/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking C executable out/tracer"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/tracer.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/tracer.dir/build: out/tracer

.PHONY : CMakeFiles/tracer.dir/build

CMakeFiles/tracer.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/tracer.dir/cmake_clean.cmake
.PHONY : CMakeFiles/tracer.dir/clean

CMakeFiles/tracer.dir/depend:
	cd /home/joseph/repos/rtc/c && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/joseph/repos/rtc/c /home/joseph/repos/rtc/c /home/joseph/repos/rtc/c /home/joseph/repos/rtc/c /home/joseph/repos/rtc/c/CMakeFiles/tracer.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/tracer.dir/depend

