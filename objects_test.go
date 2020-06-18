package main

import (
	"testing"
)

func TestNewRay(t *testing.T) {
	o := NewPoint(1,2,3)
	d := NewVector(4,5,6)
	r := NewRay(o,d)

	if !r.origin.Equals(o) || !r.direction.Equals(d) {
		t.Error("Cannot properly create new ray")
	}
}

func TestRayPosition(t *testing.T) {
	o := NewPoint(2,3,4)
	d := NewVector(1,0,0)
	r := NewRay(o,d)
	ts := []float64{0,1,-1,2.5}
	ps := []*primitive{
		NewPoint(2,3,4),
		NewPoint(3,3,4),
		NewPoint(1,3,4),
		NewPoint(4.5,3,4),
	}

	for i := range ts {
		if !r.Position(ts[i]).Equals(ps[i]) {
			t.Error("Ray position incorrect")
		}
	}
}

func TestRayIntersect(t *testing.T) {
	s := NewSphere()
	rays := []*ray{
		NewRay(NewPoint(0,0,-5), NewVector(0,0,1)),
		NewRay(NewPoint(0,1,-5), NewVector(0,0,1)),
		NewRay(NewPoint(0,2,-5), NewVector(0,0,1)),
		NewRay(NewPoint(0,0,0), NewVector(0,0,1)),
		NewRay(NewPoint(0,0,5), NewVector(0,0,1)),
	}
	counts := []int{
		2,2,0,2,2,
	}
	xss := [][]float64{
		{4,6},
		{5,5},
		{},
		{-1,1},
		{-6,-4},
	}

	for i := range rays {
		xs := rays[i].IntersectSphere(s)

		if len(xs) != counts[i] {
			t.Error("xs count incorrect")
		}
		if counts[i] != 0 && (!FloatEquals(xs[0],xss[i][0]) || !FloatEquals(xs[1],xss[i][1])) {
			t.Error("xs values incorrect")
		}
	}
}
