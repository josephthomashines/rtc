package main

import (
	"math"
	"testing"
)

func TestFloatEquals(t *testing.T) {
	a := 1.0
	b := a - EPSILON

	if !FloatEquals(a, b) {
		t.Error("FloatEquals failed")
	}
}

func TestClip(t *testing.T) {
	low := 1
	high := 3

	if Clip(low, high, 2) != 2 {
		t.Error("Clipped value incorrectly")
	}
	if Clip(low, high, 10) != 3 {
		t.Error("Clipped value incorrectly")
	}
	if Clip(low, high, 0) != 1 {
		t.Error("Clipped value incorrectly")
	}
}

func TestRadianConversion(t *testing.T) {
	d := 180.0

	if D2R(d) != math.Pi {
		t.Error("D2R incorrect")
	}

	r := math.Pi / 2

	if R2D(r) != 90.0 {
		t.Error("R2D incorrect")
	}
}
