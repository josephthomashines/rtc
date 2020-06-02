package main

import "fmt"

const POINT_W = 1
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

func (p *primitive) Equals(o *primitive) bool {
  if FloatEquals(p.x,o.x) &&
  FloatEquals(p.y,o.y) &&
  FloatEquals(p.z,o.z) &&
  FloatEquals(p.w,o.w) {
    return true
  }

  return false
}

func isPoint(p *primitive) bool {
  return p.w == POINT_W
}

func isVector(p *primitive) bool {
  return p.w == VECTOR_W
}

func addPrimitives(a,b *primitive) (*primitive, error) {
  if isPoint(a) && isPoint(b) {
    return nil, fmt.Errorf("Cannot add %s and %s, both are points", a,b)
  }

  p := newPrimitive(
    a.x + b.x,
    a.y + b.y,
    a.z + b.z,
    a.w + b.w,
  )
  return p, nil
}

func subPrimitives(a,b *primitive) (*primitive, error) {
  if isVector(a) && isPoint(b) {
    return nil, fmt.Errorf("Cannot add %s and %s, both are points", a,b)
  }

  p := newPrimitive(
    a.x - b.x,
    a.y - b.y,
    a.z - b.z,
    a.w - b.w,
  )
  return p, nil
}
