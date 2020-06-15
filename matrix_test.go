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
