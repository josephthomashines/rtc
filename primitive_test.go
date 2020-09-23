package main

import (
	"math"
	"testing"
)

func TestNewPrimitive(t *testing.T) {
	prim := NewPrimitive(1, 2, 3, 4)

	if prim.x != 1 ||
		prim.y != 2 ||
		prim.z != 3 ||
		prim.w != 4 {
		t.Error("New primitive did not correctly set values")
	}

	point := NewPoint(1, 2, 3)
	if point.x != 1 ||
		point.y != 2 ||
		point.z != 3 ||
		point.w != POINT_W {
		t.Error("New point did not correctly set values")
	}

	vector := NewVector(1, 2, 3)
	if vector.x != 1 ||
		vector.y != 2 ||
		vector.z != 3 ||
		vector.w != VECTOR_W {
		t.Error("New vector did not correctly set values")
	}

	if !prim.Equals(prim) ||
		!point.Equals(point) ||
		!vector.Equals(vector) {
		t.Error("Primitive equality failed")
	}
}

func TestAddPrimitives(t *testing.T) {
	a1 := NewPrimitive(3, -2, 5, 1)
	a2 := NewPrimitive(-2, 3, 1, 0)
	res := a1.Add(a2)

	exp := NewPrimitive(1, 1, 6, 1)
	if !res.Equals(exp) {
		t.Errorf("%s + %s should be %s, got %s", a1, a2, exp, res)
	}

	a1 = NewPoint(1, 2, 3)
	a2 = NewPoint(1, 2, 3)
}

func TestSubPrimitives(t *testing.T) {
	p1 := NewPoint(3, 2, 1)
	p2 := NewPoint(5, 6, 7)
	res := p1.Sub(p2)

	exp := NewVector(-2, -4, -6)
	if !res.Equals(exp) {
		t.Errorf("%s - %s should be %s, got %s", p1, p2, exp, res)
	}

	p := p1
	v := NewVector(5, 6, 7)
	res = p.Sub(v)

	exp = NewPoint(-2, -4, -6)
	if !res.Equals(exp) {
		t.Errorf("%s - %s should be %s, got %s", p1, p2, exp, res)
	}

	v1 := NewVector(3, 2, 1)
	v2 := v
	res = v1.Sub(v2)

	exp = NewVector(-2, -4, -6)

	if !res.Equals(exp) {
		t.Errorf("%s - %s should be %s, got %s", p1, p2, exp, res)
	}
}

func TestScalePrimitive(t *testing.T) {
	a := NewPrimitive(1, -2, 3, -4)
	scaleA := a.Scale(3.5)

	exp := NewPrimitive(3.5, -7, 10.5, -14)
	if !scaleA.Equals(exp) {
		t.Error("Scaling incorrect")
	}

	scaleA = a.Scale(0.5)

	exp = NewPrimitive(0.5, -1, 1.5, -2)
	if !scaleA.Equals(exp) {
		t.Error("Scaling incorrect")
	}
}

func TestNegatePrimitive(t *testing.T) {
	a := NewPrimitive(1, -2, 3, -4)
	negA := a.Negate()

	exp := NewPrimitive(-1, 2, -3, 4)
	if !negA.Equals(exp) {
		t.Errorf("Negation of %s should be %s, got %s", a, exp, negA)
	}
}

func TestMagnitudeVector(t *testing.T) {
	v := NewVector(1, 0, 0)
	res := v.Magnitude()

	if res != 1 {
		t.Error("Magnitude incorrectly calculated")
	}

	v = NewVector(0, 1, 0)
	res = v.Magnitude()

	if res != 1 {
		t.Error("Magnitude incorrectly calculated")
	}

	v = NewVector(0, 0, 1)
	res = v.Magnitude()

	if res != 1 {
		t.Error("Magnitude incorrectly calculated")
	}

	v = NewVector(1, 2, 3)
	res = v.Magnitude()

	if res != math.Sqrt(14) {
		t.Error("Magnitude incorrectly calculated")
	}

	v = NewVector(-1, -2, -3)
	res = v.Magnitude()

	if res != math.Sqrt(14) {
		t.Error("Magnitude incorrectly calculated")
	}
}

func TestNormalizePrimitive(t *testing.T) {
	v := NewVector(4, 0, 0)
	normV := v.Normalize()

	exp := NewVector(1, 0, 0)
	if !normV.Equals(exp) {
		t.Error("Normal incorrectly calculated")
	}

	v = NewVector(1, 2, 3)
	normV = v.Normalize()

	root14 := math.Sqrt(14)
	exp = NewVector(1/root14, 2/root14, 3/root14)
	if !normV.Equals(exp) {
		t.Error("Normal incorrectly calculated")
	}

	mag := normV.Magnitude()

	if mag != 1 {
		t.Error("Normal incorrectly calculated")
	}
}

func TestDotPrimitive(t *testing.T) {
	a := NewVector(1, 2, 3)
	b := NewVector(2, 3, 4)
	res := a.Dot(b)

	if res != 20 {
		t.Error("Dot product calculated incorrectly")
	}
}

func TestCrossPrimitive(t *testing.T) {
	a := NewVector(1, 2, 3)
	b := NewVector(2, 3, 4)
	res := a.Cross(b)

	exp := NewVector(-1, 2, -1)
	if !res.Equals(exp) {
		t.Error("Cross product calculated incorrectly")
	}

	res = b.Cross(a)

	exp = NewVector(1, -2, 1)
	if !res.Equals(exp) {
		t.Error("Cross product calculated incorrectly")
	}
}
