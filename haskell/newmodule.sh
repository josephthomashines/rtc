#!/bin/bash
#

[[ $# != 1 ]] && {
  echo "Must provide a module name";
  exit 1;
}

NAME="$1"

touch \
  src/"$NAME".hs \
  test/Test"$NAME".hs \
  demo/Demo"$NAME".hs

