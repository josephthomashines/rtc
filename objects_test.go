package main

import (
	"testing"
)

func TestNewRay(t *testing.T) {
	o := NewPoint(1, 2, 3)
	d := NewVector(4, 5, 6)
	r := NewRay(o, d)

	if !r.origin.Equals(o) || !r.direction.Equals(d) {
		t.Error("Cannot properly create new ray")
	}
}

func TestRayPosition(t *testing.T) {
	o := NewPoint(2, 3, 4)
	d := NewVector(1, 0, 0)
	r := NewRay(o, d)
	ts := []float64{0, 1, -1, 2.5}
	ps := []*primitive{
		NewPoint(2, 3, 4),
		NewPoint(3, 3, 4),
		NewPoint(1, 3, 4),
		NewPoint(4.5, 3, 4),
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
		NewRay(NewPoint(0, 0, -5), NewVector(0, 0, 1)),
		NewRay(NewPoint(0, 1, -5), NewVector(0, 0, 1)),
		NewRay(NewPoint(0, 2, -5), NewVector(0, 0, 1)),
		NewRay(NewPoint(0, 0, 0), NewVector(0, 0, 1)),
		NewRay(NewPoint(0, 0, 5), NewVector(0, 0, 1)),
	}
	counts := []int{
		2, 2, 0, 2, 2,
	}
	xss := [][]float64{
		{4, 6},
		{5, 5},
		{},
		{-1, 1},
		{-6, -4},
	}

	for i := range rays {
		xs := rays[i].IntersectSphere(s)

		if len(xs) != counts[i] {
			t.Error("xs count incorrect")
		}
		if counts[i] != 0 &&
			(!FloatEquals(xs[0].t, xss[i][0]) ||
				!FloatEquals(xs[1].t, xss[i][1]) ||
				xs[0].obj != s || xs[1].obj != s) {
			t.Error("xs values incorrect")
		}
	}

	r := NewRay(NewPoint(0, 0, -5), NewVector(0, 0, 1))
	s.transform = Transform(Scale(2, 2, 2))
	xs := r.IntersectSphere(s)

	if len(xs) != 2 ||
		!FloatEquals(xs[0].t, 3) ||
		!FloatEquals(xs[1].t, 7) {
		t.Error("Ray sphere incorrect when sphere scaled")
	}

	s.transform = Transform(Translate(5, 0, 0))
	xs = r.IntersectSphere(s)

	if len(xs) != 0 {
		t.Error("Ray sphere incorrect when sphere translated")
	}
}

func TestNewIntersection(t *testing.T) {
	s := NewSphere()
	i := NewIntersection(3.5, s)

	if i.t != 3.5 || i.obj != s {
		t.Error("Cannot create NewIntersection correctly")
	}
}

func TestIntersections(t *testing.T) {
	s := NewSphere()
	i1 := NewIntersection(1, s)
	i2 := NewIntersection(2, s)
	xs := Intersections(i1, i2)

	if len(xs) != 2 || xs[0].t != 1 || xs[1].t != 2 {
		t.Error("Cannot properly aggregate intersections")
	}
}

func TestHit(t *testing.T) {
	s := NewSphere()

	i1 := NewIntersection(1, s)
	i2 := NewIntersection(2, s)
	xs := Intersections(i1, i2)
	i := Hit(xs)

	if i != i1 {
		t.Error("Hit incorrect")
	}

	i1 = NewIntersection(-1, s)
	i2 = NewIntersection(1, s)
	xs = Intersections(i1, i2)
	i = Hit(xs)

	if i != i2 {
		t.Error("Hit incorrect")
	}

	i1 = NewIntersection(-2, s)
	i2 = NewIntersection(-1, s)
	xs = Intersections(i1, i2)
	i = Hit(xs)

	if i != nil {
		t.Error("Hit incorrect")
	}

	i1 = NewIntersection(5, s)
	i2 = NewIntersection(7, s)
	i3 := NewIntersection(-3, s)
	i4 := NewIntersection(2, s)
	xs = Intersections(i1, i2, i3, i4)
	i = Hit(xs)

	if i != i4 {
		t.Error("Hit incorrect")
	}
}

func TestRayTransform(t *testing.T) {
	r := NewRay(NewPoint(1, 2, 3), NewVector(0, 1, 0))
	m := Transform(Translate(3, 4, 5))
	tr := r.Transform(m)
	exp := NewRay(NewPoint(4, 6, 8), NewVector(0, 1, 0))

	if !exp.origin.Equals(tr.origin) ||
		!exp.direction.Equals(tr.direction) {
		t.Error("Cannot properly ray transform")
	}

	m = Transform(Scale(2, 3, 4))
	tr = r.Transform(m)
	exp = NewRay(NewPoint(2, 6, 12), NewVector(0, 3, 0))

	if !exp.origin.Equals(tr.origin) ||
		!exp.direction.Equals(tr.direction) {
		t.Error("Cannot properly ray transform")
	}
}

func TestSphere(t *testing.T) {
	s := NewSphere()

	if !s.transform.Equals(NewIdentityMatrix(4)) {
		t.Error("Sphere transform not initialized correctly")
	}

	tr := Transform(Translate(2, 3, 4))
	s.transform = tr

	if !s.transform.Equals(tr) {
		t.Error("Cannot properly set sphere transform")
	}
}
