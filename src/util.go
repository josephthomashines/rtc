package main

import (
	"math"
)

var EPSILON float64 = 1e-9

func FloatEquals(a, b float64) bool {
	return math.Abs(a-b) <= EPSILON
}

func Clip(low, high, val int) int {
	if val < low {
		return low
	}
	if val > high {
		return high
	}
	return val
}
