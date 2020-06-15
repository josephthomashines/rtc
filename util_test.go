package main

import (
	"testing"
)

func TestFloatEquals(t *testing.T) {
	a := 1.0
	b := a - EPSILON

	if !FloatEquals(a,b) {
		t.Error("FloatEquals failed")
	}
}

func TestClip(t *testing.T) {
	low := 1
	high := 3

	if Clip(low,high,2) != 2 {
		t.Error("Clipped value incorrectly")
	}
	if Clip(low,high,10) != 3 {
		t.Error("Clipped value incorrectly")
	}
	if Clip(low,high,0) != 1 {
		t.Error("Clipped value incorrectly")
	}
}
