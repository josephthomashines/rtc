package main

import (
	"math"
)

func FloatEquals(a, b float64) bool {
	return math.Abs(a-b) <= 1e-9
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
