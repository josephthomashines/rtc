#!/bin/bash
#

[[ "$@" < 1 ]] && {
  echo "Provide a directory name to search for lines";
  exit 1;
}

grep -v '(\-\-|^\s*$)' "$1"/*.hs | wc -l | awk -v d=$1 '{print "  "d" "$0}'


