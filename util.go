package main

import (
	guuid "github.com/google/uuid"
	"math"
)

var EPSILON float64 = 1e-5

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

func D2R(d float64) float64 {
	return d * (math.Pi / 180)
}

func R2D(r float64) float64 {
	return r * (180 / math.Pi)
}

func UUID() string {
	return guuid.New().String()
}
