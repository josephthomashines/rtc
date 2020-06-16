package main

import (
	"fmt"
	"math"
)

type matrix struct {
	r, c int
	data []float64
}

func NewEmptyMatrix(r, c int) *matrix {
	m := &matrix {
		r: r,
		c: c,
		data: make([]float64, r*c),
	}

	return m
}

func NewMatrix(data [][]float64) *matrix {
	r := len(data)
	c := len(data[0])

	m := NewEmptyMatrix(r,c)
	i := 0

	for _, row := range data {
		for _, col := range row {
			m.data[i] = col
			i++
		}
	}

	return m
}

func NewIdentityMatrix(n int) *matrix {
	m := NewEmptyMatrix(n,n)

	for i := 0; i<n; i++ {
		m.Set(i,i,1)
	}

	return m
}

func (m *matrix) String() string {
	out := "["

	for i:=0; i<m.r; i++ {
		if i == 0 {
			out += "["
		} else {
			out += " ["
		}

		for j:=0; j<m.c; j++ {
				out += fmt.Sprintf("%0.4f", m.data[m.Index(i,j)])
			if j != m.c-1 {
				out += " "
			}
		}

		if i == m.r-1 {
			out += "]"
		} else {
			out += "]\n"
		}
	}

	out += "]\n"
	return out
}

func (m *matrix) Equals(o *matrix) bool {
	if m.r == o.r && m.c == o.c {
		for i := range m.data {
			if !FloatEquals(m.data[i], o.data[i]) {
				return false
			}
		}
		return true
	} else {
		panic(fmt.Errorf("(%d, %d) sizes mismatch (%d, %d)\n", m.r,m.c,o.r,o.c))
	}
}


func (m *matrix) Index(r,c int) int {
	return (r*m.c) + c
}

func (m *matrix) Get(r,c int) float64 {
	if r < 0 || r >= m.r || c < 0 || c >= m.c {
		panic(fmt.Errorf("(%d, %d) out of range (%d, %d)\n", r,c,m.r,m.c))
	}

	return m.data[m.Index(r,c)]
}

func (m *matrix) Set(r,c int, v float64) {
	if r < 0 || r >= m.r || c < 0 || c >= m.c {
		panic(fmt.Errorf("(%d, %d) out of range (%d, %d)\n", r,c,m.r,m.c))
	}

	m.data[m.Index(r,c)] = v
}

func (m *matrix) Multiply(o *matrix) *matrix {
	if m.c != o.r {
		panic(fmt.Errorf("Cannot multiply matrices of shape (%d, %d) and (%d, %d)\n", m.r,m.c,o.r,o.c))
	}

	res := NewEmptyMatrix(m.r,o.c)
	s := m.c

	for row := 0; row<res.r; row++ {
		for col := 0; col<res.c; col++ {
			sum := 0.0
			for i := 0; i<s; i++ {
				sum += m.Get(row,i) * o.Get(i,col)
			}
			res.Set(row,col,sum)
		}
	}
	return res
}

func (m *matrix) MultiplyPrimitive(p *primitive) *primitive {
	o := NewMatrix([][]float64{
		{p.x},
		{p.y},
		{p.z},
		{p.w},
	})
	res := m.Multiply(o)
	return NewPrimitive(
		res.Get(0,0),
		res.Get(1,0),
		res.Get(2,0),
		res.Get(3,0),
	)
}

func (m *matrix) Transpose() *matrix {
	o := NewEmptyMatrix(m.r,m.c)

	for row := 0; row<m.r; row++ {
		for col := 0; col<m.c; col++ {
			o.Set(col,row,m.Get(row,col))
		}
	}

	return o
}

func (m *matrix) Determinant() float64 {
	if m.r != m.c {
		panic("Can only take determinant of square matrix")
	}

	// 2D Determinant
	if m.r == 2 && m.c == 2 {
		a := m.Get(0,0)
		b := m.Get(0,1)
		c := m.Get(1,0)
		d := m.Get(1,1)

		return (a*d)-(b*c)
	}

	// ND Determinant
	det := 0.0
	for col := 0; col<m.c; col++ {
		det += m.Get(0,col) * m.Cofactor(0,col)
	}

	return det
}

func (m *matrix) Submatrix(r, c int) *matrix {
	if r<0 || r>=m.r || c<0 || c>=m.c {
		panic("Invalid parameters for submatrix")
	}

	o := NewEmptyMatrix(m.r-1,m.c-1)
	i := 0

	for row := 0; row < m.r; row++ {
		for col := 0; col < m.c; col++ {
			if row != r && col != c {
				o.data[i] = m.Get(row,col)
				i++
			}
		}
	}

	return o
}

func (m *matrix) Minor(r,c int) float64 {
	return m.Submatrix(r,c).Determinant()
}

func (m *matrix) Cofactor(r,c int) float64 {
	s := 1.
	if math.Mod(float64(r+c), 2) != 0 {
		s = -1.
	}

	return s * m.Minor(r,c)
}

func (m *matrix) IsInvertible() bool {
	return m.Determinant() != 0.0
}

func (m *matrix) Inverse() *matrix {
	if !m.IsInvertible() {
		panic("Matrix not invertible")
	}

	o := NewEmptyMatrix(m.r,m.c)
	for row := 0; row<m.r; row++ {
		for col := 0; col<m.c; col++ {
			o.Set(row,col,m.Cofactor(row,col))
		}
	}

	o = o.Transpose()
	det := m.Determinant()
	for row := 0; row<o.r; row++ {
		for col := 0; col<o.c; col++ {
			o.Set(row,col,o.Get(row,col)/det)
		}
	}

	return o
}

