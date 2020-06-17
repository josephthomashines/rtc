package main

import (
	"testing"
)


func TestNewMatrix(t *testing.T) {
	m := NewMatrix([][]float64{
		{1,2,3,4},
		{5.5,6.5,7.5,8.5},
		{9,10,11,12},
		{13.5,14.5,15.5,16.5},
	})

	if !FloatEquals(m.Get(0, 0), 1) {
		t.Error("Cannot properly get from 4x4 matrix")
	}
	if !FloatEquals(m.Get(0, 3), 4) {
		t.Error("Cannot properly get from 4x4 matrix")
	}
	if !FloatEquals(m.Get(1, 0), 5.5) {
		t.Error("Cannot properly get from 4x4 matrix")
	}
	if !FloatEquals(m.Get(1, 2), 7.5) {
		t.Error("Cannot properly get from 4x4 matrix")
	}
	if !FloatEquals(m.Get(2, 2), 11) {
		t.Error("Cannot properly get from 4x4 matrix")
	}
	if !FloatEquals(m.Get(3, 0), 13.5) {
		t.Error("Cannot properly get from 4x4 matrix")
	}
	if !FloatEquals(m.Get(3, 2), 15.5) {
		t.Error("Cannot properly get from 4x4 matrix")
	}

	m = NewMatrix([][]float64{
		{-3,5},
		{1,-2},
	})
	if !FloatEquals(m.Get(0, 0), -3) {
		t.Error("Cannot properly get from 2x2 matrix")
	}
	if !FloatEquals(m.Get(0, 1), 5) {
		t.Error("Cannot properly get from 2x2 matrix")
	}
	if !FloatEquals(m.Get(1, 0), 1) {
		t.Error("Cannot properly get from 2x2 matrix")
	}
	if !FloatEquals(m.Get(1, 1), -2) {
		t.Error("Cannot properly get from 2x2 matrix")
	}

	m = NewMatrix([][]float64{
		{-3,5,0},
		{1,-2,-7},
		{0, 1, 1},
	})
	if !FloatEquals(m.Get(0, 0), -3) {
		t.Error("Cannot properly get from 3x3 matrix")
	}
	if !FloatEquals(m.Get(1, 1), -2) {
		t.Error("Cannot properly get from 3x3 matrix")
	}
	if !FloatEquals(m.Get(2, 2), 1) {
		t.Error("Cannot properly get from 3x3 matrix")
	}
}

func TestMatrixEquals(t *testing.T) {
	A := NewMatrix([][]float64{
		{1,2,3,4},
		{5,6,7,8},
		{9,8,7,6},
		{5,4,3,2},
	})
	if !A.Equals(A) {
		t.Error("Matrix identical equality incorrect")
	}

	B := NewMatrix([][]float64{
		{2,3,4,5},
		{6,7,8,9},
		{8,7,6,5},
		{4,3,2,1},
	})
	if A.Equals(B) {
		t.Error("Matrix different equality incorrect")
	}
}

func TestMatrixMultiply(t *testing.T) {
	A := NewMatrix([][]float64{
		{1,2,3,4},
		{5,6,7,8},
		{9,8,7,6},
		{5,4,3,2},
	})
	B := NewMatrix([][]float64{
		{-2,1,2,3},
		{3,2,1,-1},
		{4,3,6,5},
		{1,2,7,8},
	})
	AB := NewMatrix([][]float64{
		{20,22,50,48},
		{44,54,114,108},
		{40,58,110,102},
		{16,26,46,42},
	})

	if !AB.Equals(A.Multiply(B)) {
		t.Error("Matrix multiplication incorrect")
	}
}

func TestMatrixMultiplyPrimitive(t *testing.T) {
	A := NewMatrix([][]float64{
		{1,2,3,4},
		{2,4,4,2},
		{8,6,4,1},
		{0,0,0,1},
	})
	b := NewPrimitive(1,2,3,1)
	Ab := NewPrimitive(18,24,33,1)

	if !Ab.Equals(A.MultiplyPrimitive(b)) {
		t.Error("Matrix multiply primitive incorrect")
	}
}

func TestIdentity(t *testing.T) {
	m := NewIdentityMatrix(4)
	i4 := NewMatrix([][]float64{
		{1,0,0,0},
		{0,1,0,0},
		{0,0,1,0},
		{0,0,0,1},
	})

	if !m.Equals(i4) {
		t.Error("Cannot properly create Identity matrix")
	}

	A := NewMatrix([][]float64{
		{0,1,2,4},
		{1,2,4,8},
		{2,4,8,16},
		{4,8,16,32},
	})

	if !A.Equals(A.Multiply(i4)) {
		t.Error("AI != A")
	}

	a := NewPrimitive(1,2,3,4)

	if !a.Equals(i4.MultiplyPrimitive(a)) {
		t.Error("Ia != a")
	}
}

func TestMatrixTranspose(t *testing.T) {
	m := NewMatrix([][]float64{
		{0,9,3,0},
		{9,8,0,8},
		{1,8,5,3},
		{0,0,5,8},
	})
	mT := NewMatrix([][]float64{
		{0,9,1,0},
		{9,8,8,0},
		{3,0,5,5},
		{0,8,3,8},
	})

	if !mT.Equals(m.Transpose()) {
		t.Error("Matrix transpose incorrect")
	}
}

func TestMatrixDeterminant(t *testing.T) {
	m := NewMatrix([][]float64{
		{1,5},
		{-3,2},
	})

	if m.Determinant() != 17 {
		t.Error("2D Matrix determinant incorrect")
	}

	A := NewMatrix([][]float64{
		{1,2,6},
		{-5,8,-4},
		{2,6,4},
	})

	if A.Cofactor(0,0) != 56 ||
		A.Cofactor(0,1) != 12 ||
		A.Cofactor(0,2) != -46 ||
		A.Determinant() != -196 {
		t.Error("3D Matrix Determinant incorrect")
	}

	A = NewMatrix([][]float64{
		{-2,-8,3,5},
		{-3,1,7,3},
		{1,2,-9,6},
		{-6,7,7,-9},
	})

	if A.Cofactor(0,0) != 690 ||
		A.Cofactor(0,1) != 447 ||
		A.Cofactor(0,2) != 210 ||
		A.Cofactor(0,3) != 51 ||
		A.Determinant() != -4071 {
		t.Error("3D Matrix Determinant incorrect")
	}
}

func TestSubMatrix(t *testing.T) {
	A := NewMatrix([][]float64{
		{1,5,0},
		{-3,2,7},
		{0,6,-3},
	})
	sA := NewMatrix([][]float64{
		{-3,2},
		{0,6},
	})

	if !sA.Equals(A.Submatrix(0,2)) {
		t.Error("Submatrix incorrect")
	}

	A = NewMatrix([][]float64{
		{-6,1,1,6},
		{-8,5,8,6},
		{-1,0,8,2},
		{-7,1,-1,1},
	})
	sA = NewMatrix([][]float64{
		{-6,1,6},
		{-8,8,6},
		{-7,-1,1},
	})

	if !sA.Equals(A.Submatrix(2,1)) {
		t.Error("Submatrix incorrect")
	}
}

func TestMatrixMinor(t *testing.T) {
	A := NewMatrix([][]float64{
		{3,5,0},
		{2,-1,-7},
		{6,-1,5},
	})
	sA := A.Submatrix(1,0)

	if sA.Determinant() != A.Minor(1,0) {
		t.Error("Matrix minor incorrect")
	}
}

func TestMatrixCofactor(t *testing.T) {
	A := NewMatrix([][]float64{
		{3,5,0},
		{2,-1,-7},
		{6,-1,5},
	})

	if A.Minor(0,0) != A.Cofactor(0,0) {
		t.Error("Matrix cofactor incorrect")
	}

	if A.Minor(1,0) != -1*A.Cofactor(1,0) {
		t.Error("Matrix cofactor incorrect")
	}
}

func TestMatrixInverse(t *testing.T) {
	A := NewMatrix([][]float64{
		{6,4,4,4},
		{5,5,7,6},
		{4,-9,3,-7,},
		{9,1,7,-6},
	})

	if !A.IsInvertible() {
		t.Error("Matrix IsInvertible incorrect")
	}

	A = NewMatrix([][]float64{
		{-4,2,-2,-3},
		{9,6,2,6},
		{0,-5,1,-5},
		{0,0,0,0},
	})

	if A.IsInvertible() {
		t.Error("Matrix IsInvertible incorrect")
	}

	A = NewMatrix([][]float64{
		{-5,2,6,-8},
		{1,-5,1,8},
		{7,7,-6,-7},
		{1,-3,7,4},
	})
	B := A.Inverse()
	exp := NewMatrix([][]float64{
		{0.21805,0.45113,0.24060,-0.04511},
		{-0.80827,-1.45677,-0.44361,0.52068},
		{-0.07895,-0.22368,-0.05263,0.19737},
		{-0.52256,-0.81391,-0.30075,0.30639},
	})

	if A.Determinant() != 532 ||
		A.Cofactor(2,3) != -160 ||
		!FloatEquals(B.Get(3,2),-160./532.) ||
		A.Cofactor(3,2) != 105 ||
		!FloatEquals(B.Get(2,3),105./532.) ||
		!B.Equals(exp) {
		t.Error("Matrix inverse incorrect")
	}

	if !A.Equals(B.Inverse()) {
		t.Error("Cannot invert matrix twice back to self")
	}

	A = NewMatrix([][]float64{
		{8,-5,9,2},
		{7,5,6,1},
		{-6,0,9,6},
		{-3,0,-9,-4},
	})
	exp = NewMatrix([][]float64{
		{-0.15385,-0.15385,-0.28205,-0.53846},
		{-0.07692,0.12308,0.02564,0.03077},
		{0.35897,0.35897,0.43590,0.92308},
		{-0.69231,-0.69231,-0.76923,-1.92308},
	})

	if !exp.Equals(A.Inverse()) {
		t.Error("Cannot invert matrix twice back to self")
	}

	A = NewMatrix([][]float64{
		{9,3,0,9},
		{-5,-2,-6,-3},
		{-4,9,6,4},
		{-7,6,6,2},
	})
	exp = NewMatrix([][]float64{
		{-0.04074,-0.07778,0.14444,-0.22222},
		{-0.07778,0.03333,0.36667,-0.33333},
		{-0.02901,-0.14630,-0.10926,0.12963},
		{0.17778,0.06667,-0.26667,0.33333},
	})

	if !exp.Equals(A.Inverse()) {
		t.Error("Cannot invert matrix twice back to self")
	}

	A = NewMatrix([][]float64{
		{3,-9,7,3},
		{3,-8,2,-9},
		{-4,4,4,1},
		{-6,5,-1,1},
	})
	B = NewMatrix([][]float64{
		{8,2,2,2},
		{3,-1,7,0},
		{7,0,5,4},
		{6,-2,0,5},
	})
	C := A.Multiply(B)

	if !A.Equals(C.Multiply(B.Inverse())) {
		t.Error("Matrix inverse incorrect")
	}
}
