package main

import (
	"math"
)

func Translate(x, y, z float64) func(*matrix) *matrix {
	return func(m *matrix) *matrix {
		return NewMatrix([][]float64{
			{1, 0, 0, x},
			{0, 1, 0, y},
			{0, 0, 1, z},
			{0, 0, 0, 1},
		}).Multiply(m)
	}
}

func Scale(x, y, z float64) func(*matrix) *matrix {
	return func(m *matrix) *matrix {
		return NewMatrix([][]float64{
			{x, 0, 0, 0},
			{0, y, 0, 0},
			{0, 0, z, 0},
			{0, 0, 0, 1},
		}).Multiply(m)
	}
}

func RotateX(r float64) func(*matrix) *matrix {
	return func(m *matrix) *matrix {
		return NewMatrix([][]float64{
			{1, 0, 0, 0},
			{0, math.Cos(r), -math.Sin(r), 0},
			{0, math.Sin(r), math.Cos(r), 0},
			{0, 0, 0, 1},
		}).Multiply(m)
	}
}

func RotateY(r float64) func(*matrix) *matrix {
	return func(m *matrix) *matrix {
		return NewMatrix([][]float64{
			{math.Cos(r), 0, math.Sin(r), 0},
			{0, 1, 0, 0},
			{-math.Sin(r), 0, math.Cos(r), 0},
			{0, 0, 0, 1},
		}).Multiply(m)
	}
}

func RotateZ(r float64) func(*matrix) *matrix {
	return func(m *matrix) *matrix {
		return NewMatrix([][]float64{
			{math.Cos(r), -math.Sin(r), 0, 0},
			{math.Sin(r), math.Cos(r), 0, 0},
			{0, 0, 1, 0},
			{0, 0, 0, 1},
		}).Multiply(m)
	}
}

func Shear(xy, xz, yx, yz, zx, zy float64) func(*matrix) *matrix {
	return func(m *matrix) *matrix {
		return NewMatrix([][]float64{
			{1, xy, xz, 0},
			{yx, 1, yz, 0},
			{zx, zy, 1, 0},
			{0, 0, 0, 1},
		}).Multiply(m)
	}
}

func Transform(options ...func(*matrix) *matrix) *matrix {
	m := NewIdentityMatrix(4)

	for _, option := range options {
		m = option(m)
	}

	return m
}

func DemoTransform() {
	S := 500.
	R := float64(S) * 3. / 8.
	c := NewCanvas(int(S), int(S))
	col := NewColor(1, 1, 0)
    p := NewPoint(0, 0, 1)

	for i := 0; i < 12; i++ {
		tr := Transform(
			RotateY(float64(i)*math.Pi/6),
            Scale(R, 1, R),
            Translate(S/2, 0, S/2),
		)

		np := tr.MultiplyPrimitive(p)
		c.WritePixel(int(np.x), int(S-np.z), col)
	}

	if err := c.Save("./DemoTransform.ppm"); err != nil {
		panic(err)
	}
}
