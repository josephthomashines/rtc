package main

import (
  "math"
)

func FloatEquals(a,b float64) bool {
  return math.Abs(a-b) <= 1e-9
}
