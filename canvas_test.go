package main

import (
	"strings"
	"testing"
)

func TestNewCanvas(t *testing.T) {
	c := NewCanvas(10, 20)

	if c.width != 10 || c.height != 20 {
		t.Error("Canvas size set incorrectly")
	}

	black := NewColor(0, 0, 0)
	for i := 0; i < 20; i++ {
		for j := 0; j < 10; j++ {
			if !c.GetPixel(j, i).Equals(black) {
				t.Errorf("Color at (%d,%d) is not black", j, i)
			}
		}
	}
}

func TestCanvasWritePixel(t *testing.T) {
	c := NewCanvas(10, 20)
	red := NewColor(1, 0, 0)

	c.WritePixel(2, 3, red)
	if !c.GetPixel(2, 3).Equals(red) {
		t.Error("Write pixel failed")
	}
}

func TestToPPM(t *testing.T) {
	c := NewCanvas(5, 3)

	ppm := c.ToPPM()
	toks := strings.Split(ppm, "\n")

	for i, tok := range toks[:3] {
		toks[i] = strings.TrimSpace(tok)
	}

	if toks[0] != "P3" ||
		toks[1] != "5 3" ||
		toks[2] != "255" {
		t.Error("PPM header incorrect")
	}

	c.WritePixel(0, 0, NewColor(1.5, 0, 0))
	c.WritePixel(2, 1, NewColor(0, 0.5, 0))
	c.WritePixel(4, 2, NewColor(-0.5, 0, 1))
}
