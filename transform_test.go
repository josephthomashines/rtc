package main

import (
	"math"
	"testing"
)

func TestTranslation(t *testing.T) {
    tr := Transform(Translate(5, -3, 2))
	p := NewPoint(-3, 4, 5)
	exp := NewPoint(2, 1, 7)

	if !exp.Equals(tr.MultiplyPrimitive(p)) {
		t.Error("Translation matrix incorrect")
	}

	tri := tr.Inverse()
	exp = NewPoint(-8, 7, 3)

	if !exp.Equals(tri.MultiplyPrimitive(p)) {
		t.Error("Translation matrix incorrect")
	}

	v := NewVector(-3, 4, 5)

	if !v.Equals(tr.MultiplyPrimitive(v)) {
		t.Error("Translation matrix incorrect")
	}
}

func TestScaling(t *testing.T) {
    tr := Transform(Scale(2, 3, 4))
	p := NewPoint(-4, 6, 8)
	exp := NewPoint(-8, 18, 32)

	if !exp.Equals(tr.MultiplyPrimitive(p)) {
		t.Error("Scaling matrix incorrect")
	}

	v := NewPoint(-4, 6, 8)
	exp = NewPoint(-8, 18, 32)

	if !exp.Equals(tr.MultiplyPrimitive(v)) {
		t.Error("Scaling matrix incorrect")
	}

	tri := tr.Inverse()
	exp = NewPoint(-2, 2, 2)

	if !exp.Equals(tri.MultiplyPrimitive(v)) {
		t.Error("Scaling matrix incorrect")
	}

	tr = Transform(Scale(-1, 1, 1))
	p = NewPoint(2, 3, 4)
	exp = NewPoint(-2, 3, 4)

	if !exp.Equals(tr.MultiplyPrimitive(p)) {
		t.Error("Scaling matrix incorrect")
	}
}

func TestRotation(t *testing.T) {
	// Shared
	r2o2 := math.Sqrt(2) / 2.

	// RotationX
	p := NewPoint(0, 1, 0)
	hq := Transform(RotateX(math.Pi / 4))
	fq := Transform(RotateX(math.Pi / 2))
	ehq := NewPoint(0, r2o2, r2o2)
	efq := NewPoint(0, 0, 1)

	if !ehq.Equals(hq.MultiplyPrimitive(p)) ||
		!efq.Equals(fq.MultiplyPrimitive(p)) {
		t.Error("RotationX incorrect")
	}

	inv := hq.Inverse()
	ehq = NewPoint(0, r2o2, -r2o2)

	if !ehq.Equals(inv.MultiplyPrimitive(p)) {
		t.Error("RotationX incorrect")
	}

	// RotationY
	p = NewPoint(0, 0, 1)
	hq = Transform(RotateY(math.Pi / 4))
	fq = Transform(RotateY(math.Pi / 2))
	ehq = NewPoint(r2o2, 0, r2o2)
	efq = NewPoint(1, 0, 0)

	if !ehq.Equals(hq.MultiplyPrimitive(p)) ||
		!efq.Equals(fq.MultiplyPrimitive(p)) {
		t.Error("RotationY incorrect")
	}

	// RotationZ
	p = NewPoint(0, 1, 0)
	hq = Transform(RotateZ(math.Pi / 4))
	fq = Transform(RotateZ(math.Pi / 2))
	ehq = NewPoint(-r2o2, r2o2, 0)
	efq = NewPoint(-1, 0, 0)

	if !ehq.Equals(hq.MultiplyPrimitive(p)) ||
		!efq.Equals(fq.MultiplyPrimitive(p)) {
		t.Error("RotationZ incorrect")
	}
}

func TestShearing(t *testing.T) {
	p := NewPoint(2, 3, 4)
	trs := []*matrix{
		Transform(Shear(1, 0, 0, 0, 0, 0)),
		Transform(Shear(0, 1, 0, 0, 0, 0)),
		Transform(Shear(0, 0, 1, 0, 0, 0)),
		Transform(Shear(0, 0, 0, 1, 0, 0)),
		Transform(Shear(0, 0, 0, 0, 1, 0)),
		Transform(Shear(0, 0, 0, 0, 0, 1)),
	}
	exps := []*primitive{
		NewPoint(5, 3, 4),
		NewPoint(6, 3, 4),
		NewPoint(2, 5, 4),
		NewPoint(2, 7, 4),
		NewPoint(2, 3, 6),
		NewPoint(2, 3, 7),
	}

	for i := range trs {
		if !exps[i].Equals(trs[i].MultiplyPrimitive(p)) {
			t.Error("Shearing incorrect")
		}
	}
}

func TestChainingTransformation(t *testing.T) {
	p := NewPoint(1, 0, 1)
    A := Transform(RotateX(math.Pi / 2))
    B := Transform(Scale(5,5,5))
    C := Transform(Translate(10,5,7))

	p2 := A.MultiplyPrimitive(p)
	if !p2.Equals(NewPoint(1, -1, 0)) {
		t.Error("Chaining transformations incorrect")
	}
	p3 := B.MultiplyPrimitive(p2)
	if !p3.Equals(NewPoint(5, -5, 0)) {
		t.Error("Chaining transformations incorrect")
	}
	p4 := C.MultiplyPrimitive(p3)
	if !p4.Equals(NewPoint(15, 0, 7)) {
		t.Error("Chaining transformations incorrect")
	}

	T := C.Multiply(B.Multiply(A))
	p5 := T.MultiplyPrimitive(p)
	if !p5.Equals(NewPoint(15, 0, 7)) {
		t.Error("Chaining transformations incorrect")
	}

    T = Transform(RotateX(math.Pi / 2), Scale(5,5,5), Translate(10,5,7))
	if !p5.Equals(NewPoint(15, 0, 7)) {
		t.Error("Chaining transformations API incorrect")
	}
}

