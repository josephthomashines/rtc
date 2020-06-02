package main

import "testing"

func TestNewPrimitive(t *testing.T) {
	prim := newPrimitive(1, 2, 3, 4)

	if prim.x != 1 ||
		prim.y != 2 ||
		prim.z != 3 ||
		prim.w != 4 {
		t.Error("New primitive did not correctly set values")
	}

  point := newPoint(1,2,3)
  if point.x != 1 ||
  point.y != 2 ||
  point.z != 3 ||
  point.w != POINT_W {
		t.Error("New point did not correctly set values")
  }
}
