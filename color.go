package main

import "fmt"

type color struct {
	r, g, b float64
}

func (c *color) String() string {
	return fmt.Sprintf("( %0.2f, %0.2f, %0.2f )", c.r, c.g, c.b)
}

func NewColor(r, g, b float64) *color {
	return &color{r, g, b}
}

func (c *color) Equals(o *color) bool {
	if FloatEquals(c.r, o.r) &&
		FloatEquals(c.g, o.g) &&
		FloatEquals(c.b, o.b) {
		return true
	}

	return false
}

func (c *color) Add(o *color) *color {
	return NewColor(
		c.r+o.r,
		c.g+o.g,
		c.b+o.b,
	)
}

func (c *color) Sub(o *color) *color {
	return NewColor(
		c.r-o.r,
		c.g-o.g,
		c.b-o.b,
	)
}

func (c *color) Scale(s float64) *color {
	return NewColor(
		s*c.r,
		s*c.g,
		s*c.b,
	)
}

func (c *color) Blend(o *color) *color {
	return NewColor(
		c.r*o.r,
		c.g*o.g,
		c.b*o.b,
	)
}
