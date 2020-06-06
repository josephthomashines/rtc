package main

import "testing"

func TestNewColor(t *testing.T) {
	c := NewColor(-0.5, 0.4, 1.7)

	if c.r != -0.5 ||
		c.g != 0.4 ||
		c.b != 1.7 {
		t.Error("New color not set properly")
	}
}

func TestAddColors(t *testing.T) {
	c1 := NewColor(0.9, 0.6, 0.75)
	c2 := NewColor(0.7, 0.1, 0.25)
	res := c1.Add(c2)

	exp := NewColor(1.6, 0.7, 1.0)
	if !res.Equals(exp) {
		t.Error("Add colors incorrect")
	}
}

func TestSubColors(t *testing.T) {
	c1 := NewColor(0.9, 0.6, 0.75)
	c2 := NewColor(0.7, 0.1, 0.25)
	res := c1.Sub(c2)

	exp := NewColor(0.2, 0.5, 0.5)
	if !res.Equals(exp) {
		t.Error("Sub colors incorrect")
	}
}

func TestScaleColor(t *testing.T) {
	c := NewColor(0.2, 0.3, 0.4)
	res := c.Scale(2)

	exp := NewColor(0.4, 0.6, 0.8)
	if !res.Equals(exp) {
		t.Error("Scale color incorrect")
	}
}

func TestBlendColors(t *testing.T) {
	c1 := NewColor(1, 0.2, 0.4)
	c2 := NewColor(0.9, 1, 0.1)
	res := c1.Blend(c2)

	exp := NewColor(0.9, 0.2, 0.04)
	if !res.Equals(exp) {
		t.Error("Blend colors incorrect")
	}
}
