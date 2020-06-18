package main

import (
	"math"
)

func NewTranslation(x, y, z float64) *matrix {
	return NewMatrix([][]float64{
		{1, 0, 0, x},
		{0, 1, 0, y},
		{0, 0, 1, z},
		{0, 0, 0, 1},
	})
}

func NewScaling(x, y, z float64) *matrix {
	return NewMatrix([][]float64{
		{x, 0, 0, 0},
		{0, y, 0, 0},
		{0, 0, z, 0},
		{0, 0, 0, 1},
	})
}

func NewRotationX(r float64) *matrix {
	return NewMatrix([][]float64{
		{1, 0, 0, 0},
		{0, math.Cos(r), -math.Sin(r), 0},
		{0, math.Sin(r), math.Cos(r), 0},
		{0, 0, 0, 1},
	})
}

func NewRotationY(r float64) *matrix {
	return NewMatrix([][]float64{
		{math.Cos(r), 0, math.Sin(r), 0},
		{0, 1, 0, 0},
		{-math.Sin(r), 0, math.Cos(r), 0},
		{0, 0, 0, 1},
	})
}

func NewRotationZ(r float64) *matrix {
	return NewMatrix([][]float64{
		{math.Cos(r), -math.Sin(r), 0, 0},
		{math.Sin(r), math.Cos(r), 0, 0},
		{0, 0, 1, 0},
		{0, 0, 0, 1},
	})
}

func NewShearing(xy, xz, yx, yz, zx, zy float64) *matrix {
	return NewMatrix([][]float64{
		{1, xy, xz, 0},
		{yx, 1, yz, 0},
		{zx, zy, 1, 0},
		{0, 0, 0, 1},
	})
}

func DemoTransform() {
	S := 500
	RADIUS := float64(S) * 3. / 8.
	c := NewCanvas(S, S)
	col := NewColor(1, 1, 0)

	for i := 0; i < 12; i++ {
		p := NewPoint(0, 1, 0)

		rot := NewRotationZ(float64(i) * math.Pi / 6)
		s := NewScaling(RADIUS, RADIUS, 0)
		tr := s.Multiply(rot)

		np := tr.MultiplyPrimitive(p)
		c.WritePixel(int(np.x)+S/2, int(np.y)+S/2, col)
	}

	if err := c.Save("./DemoTransform.ppm"); err != nil {
		panic(err)
	}
}
