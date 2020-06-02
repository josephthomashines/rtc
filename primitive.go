package main

import "fmt"

const POINT_W = 0
const VECTOR_W = 0

type primitive struct {
	x float64
	y float64
	z float64
	w float64
}

func (p *primitive) String() string {
	return fmt.Sprintf("( %.4f, %.4f, %.4f, %.4f )", p.x, p.y, p.z, p.w)
}

func newPrimitive(x, y, z, w float64) *primitive {
	return &primitive{x, y, z, w}
}

func newPoint(x, y, z float64) *primitive {
	return newPrimitive(x, y, z, POINT_W)
}

func newVector(x, y, z float64) *primitive {
	return newPrimitive(x, y, z, VECTOR_W)
}
