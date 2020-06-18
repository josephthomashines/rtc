package main

import (
	"fmt"
	"log"
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
	return fmt.Sprintf("( %.2f, %.2f, %.2f, %.2f )", p.x, p.y, p.z, p.w)
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

func (a *primitive) Add(b *primitive) *primitive {
	if a.IsPoint() && b.IsPoint() {
		panic(fmt.Errorf("Cannot Add %s and %s, both are points", a, b))
	}

	p := NewPrimitive(
		a.x+b.x,
		a.y+b.y,
		a.z+b.z,
		a.w+b.w,
	)
	return p
}

func (a *primitive) Sub(b *primitive) *primitive {
	if a.IsVector() && b.IsPoint() {
		panic(fmt.Errorf("Cannot Add %s and %s, both are points", a, b))
	}

	p := NewPrimitive(
		a.x-b.x,
		a.y-b.y,
		a.z-b.z,
		a.w-b.w,
	)
	return p
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

func (p *primitive) Magnitude() float64 {
	if !p.IsVector() {
		panic(fmt.Errorf("Only vectors have magnitude"))
	}

	m := math.Sqrt(
		(p.x * p.x) +
			(p.y * p.y) +
			(p.z * p.z) +
			(p.w * p.w))

	return m
}

func (p *primitive) Normalize() *primitive {
	mag := p.Magnitude()

	return p.Scale(1. / mag)
}

func (a *primitive) Dot(b *primitive) float64 {
	if !(a.IsVector() && b.IsVector()) {
		panic(fmt.Errorf("Can only get dot product of vectors"))
	}

	d := (a.x * b.x) +
		(a.y * b.y) +
		(a.z * b.z) +
		(a.w * b.w)

	return d
}

func (a *primitive) Cross(b *primitive) *primitive {
	if !(a.IsVector() && b.IsVector()) {
		panic(fmt.Errorf("Can only get dot product of vectors"))
	}

	p := NewVector(
		(a.y*b.z)-(a.z*b.y),
		(a.z*b.x)-(a.x*b.z),
		(a.x*b.y)-(a.y*b.x),
	)
	return p
}

// ---------------------------------------------------------------------------
// Demo

type DemoProjectile struct {
	position, velocity *primitive
}

type DemoEnvironment struct {
	gravity, wind *primitive
}

func DemoTick(env *DemoEnvironment, proj *DemoProjectile) {
	tempPosition := proj.position.Add(proj.velocity)
	proj.position = tempPosition

	tempGravity := env.gravity.Add(env.wind)
	tempVelocity := proj.velocity.Add(tempGravity)
	proj.velocity = tempVelocity

	return
}

func DemoPrimitive() {
	tempVelocity := NewVector(1, 1, 0).Normalize()

	proj := &DemoProjectile{
		NewPoint(0, 1, 0),
		tempVelocity,
	}
	env := &DemoEnvironment{
		NewVector(0, -0.1, 0),
		NewVector(-0.01, 0, 0),
	}

	for proj.position.y > 0 {
		log.Println(proj.position)
		DemoTick(env, proj)
	}

	proj.position.y = 0
	log.Println(proj.position)
}
