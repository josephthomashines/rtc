package main

import (
	"math"
	"sort"
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

func (r *ray) IntersectSphere(s *sphere) []*intersection {
	r2 := r.Transform(s.transform.Inverse())

	sphereToRay := r2.origin.Sub(NewPoint(0,0,0))
	a := r2.direction.Dot(r2.direction)
	b := 2 * r2.direction.Dot(sphereToRay)
	c := sphereToRay.Dot(sphereToRay) - 1
	disc := math.Pow(b,2) - 4 * a * c

	if disc < 0 {
		return []*intersection{}
	}

	t1 := (-b - math.Sqrt(disc)) / (2*a)
	t2 := (-b + math.Sqrt(disc)) / (2*a)

	return Intersections(NewIntersection(t1,s),NewIntersection(t2,s))
}

func (r *ray) Transform(tr *matrix) *ray {
	return NewRay(
		tr.MultiplyPrimitive(r.origin),
		tr.MultiplyPrimitive(r.direction),
	)
}

type object interface {
	GetId() string
}

type sphere struct {
	id string
	transform *matrix
}

func NewSphere() *sphere {
	return &sphere{
		id: UUID(),
		transform: NewIdentityMatrix(4),
	}
}

func (s *sphere) GetId() string {
	return s.id
}

type intersection struct {
	t float64
	obj object
}

func NewIntersection(t float64, obj object) *intersection {
	return &intersection{
		t: t,
		obj: obj,
	}
}

func Intersections(is ...*intersection) []*intersection {
	sort.Slice(is, func(i, j int) bool {
		return is[i].t < is[j].t
	})
	return is
}

func Hit(xs []*intersection) *intersection {
	for _, x := range xs {
		if x.t >= 0 {
			return x
		}
	}

	return nil
}


