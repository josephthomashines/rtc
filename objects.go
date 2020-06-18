package main

import (
	"math"
)

type ray struct {
	origin *primitive
	direction *primitive
}

func NewRay(o,d *primitive) *ray {
	if !o.IsPoint() {
		panic("Origin must be point")
	}

	if !d.IsVector() {
		panic("Direction must be vector")
	}

	return &ray{
		origin: o,
		direction: d,
	}
}

func (r *ray) Position(t float64) *primitive {
	p := r.origin.Add(r.direction.Scale(t))

	return p
}

func (r *ray) IntersectSphere(s *sphere) []float64 {
	sphereToRay := r.origin.Sub(NewPoint(0,0,0))
	a := r.direction.Dot(r.direction)
	b := 2 * r.direction.Dot(sphereToRay)
	c := sphereToRay.Dot(sphereToRay) - 1
	disc := math.Pow(b,2) - 4 * a * c

	if disc < 0 {
		return []float64{}
	}

	t1 := (-b - math.Sqrt(disc)) / (2*a)
	t2 := (-b + math.Sqrt(disc)) / (2*a)

	return []float64{t1,t2}
}

type sphere struct {
	id string
}

func NewSphere() *sphere {
	return &sphere{
		id: UUID(),
	}
}
