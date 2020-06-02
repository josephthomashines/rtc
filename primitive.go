package main

import (
	"fmt"
	"math"
)

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

func NewPrimitive(x, y, z, w float64) *primitive {
	return &primitive{x, y, z, w}
}

func NewPoint(x, y, z float64) *primitive {
	return NewPrimitive(x, y, z, POINT_W)
}

func NewVector(x, y, z float64) *primitive {
	return NewPrimitive(x, y, z, VECTOR_W)
}

func (p *primitive) Equals(o *primitive) bool {
	if FloatEquals(p.x, o.x) &&
		FloatEquals(p.y, o.y) &&
		FloatEquals(p.z, o.z) &&
		FloatEquals(p.w, o.w) {
		return true
	}

	return false
}

func (p *primitive) IsPoint() bool {
	return p.w == POINT_W
}

func (p *primitive) IsVector() bool {
	return p.w == VECTOR_W
}

func (a *primitive) Add(b *primitive) (*primitive, error) {
	if a.IsPoint() && b.IsPoint() {
		return nil, fmt.Errorf("Cannot Add %s and %s, both are points", a, b)
	}

	p := NewPrimitive(
		a.x+b.x,
		a.y+b.y,
		a.z+b.z,
		a.w+b.w,
	)
	return p, nil
}

func (a *primitive) Sub(b *primitive) (*primitive, error) {
	if a.IsVector() && b.IsPoint() {
		return nil, fmt.Errorf("Cannot Add %s and %s, both are points", a, b)
	}

	p := NewPrimitive(
		a.x-b.x,
		a.y-b.y,
		a.z-b.z,
		a.w-b.w,
	)
	return p, nil
}

func (p *primitive) Scale(s float64) *primitive {
	return NewPrimitive(
		s*p.x,
		s*p.y,
		s*p.z,
		s*p.w,
	)
}

func (p *primitive) Negate() *primitive {
	return p.Scale(-1)
}

func (p *primitive) Magnitude() (float64, error) {
	if !p.IsVector() {
		return 0, fmt.Errorf("Only vectors have magnitude")
	}

	m := math.Sqrt(
		(p.x * p.x) +
			(p.y * p.y) +
			(p.z * p.z) +
			(p.w * p.w))

	return m, nil
}

func (p *primitive) Normalize() (*primitive, error) {
	mag, err := p.Magnitude()

	if err != nil {
		return nil, err
	}

	return p.Scale(1. / mag), nil
}

func (a *primitive) Dot(b *primitive) (float64, error) {
	if !(a.IsVector() && b.IsVector()) {
		return 0, fmt.Errorf("Can only get dot product of vectors")
	}

	d := (a.x * b.x) +
		(a.y * b.y) +
		(a.z * b.z) +
		(a.w * b.w)

	return d, nil
}

func (a *primitive) Cross(b *primitive) (*primitive, error) {
	if !(a.IsVector() && b.IsVector()) {
		return nil, fmt.Errorf("Can only get dot product of vectors")
	}

	p := NewVector(
		(a.y*b.z)-(a.z*b.y),
		(a.z*b.x)-(a.x*b.z),
		(a.x*b.y)-(a.y*b.x),
	)
	return p, nil
}

// ---------------------------------------------------------------------------
// Demo

type DPProjectile struct {
	position, velocity *primitive
}

type DPEnvironment struct {
	gravity, wind *primitive
}

func DemoPrimitiveTick(env *DPEnvironment, proj *DPProjectile) {
	tempPosition, err := proj.position.Add(proj.velocity)

	if err != nil {
		fmt.Println(err)
		return
	}

	proj.position = tempPosition

	tempGravity, err := env.gravity.Add(env.wind)

	if err != nil {
		fmt.Println(err)
		return
	}

	tempVelocity, err := proj.velocity.Add(tempGravity)

	if err != nil {
		fmt.Println(err)
		return
	}

	proj.velocity = tempVelocity
	return
}

func DemoPrimitive() {
	tempVelocity, err := NewVector(1, 1, 0).Normalize()

	if err != nil {
		fmt.Println(err)
		return
	}

	proj := &DPProjectile{
		NewPoint(0, 1, 0),
		tempVelocity,
	}
	env := &DPEnvironment{
		NewVector(0, -0.1, 0),
		NewVector(-0.01, 0, 0),
	}

	for proj.position.y > 0 {
		fmt.Println(proj.position)
		DemoPrimitiveTick(env, proj)
	}

	proj.position.y = 0
	fmt.Println(proj.position)
}
