package main

import (
	"fmt"
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

func (m *matrix) String() string {
	out := "["

	for i:=0; i<m.r; i++ {
		if i == 0 {
			out += "["
		} else {
			out += " ["
		}

		for j:=0; j<m.c; j++ {
				out += fmt.Sprintf("%0.2f", m.data[m.Index(i,j)])
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
			res.data[res.Index(row,col)] = sum
		}
	}
	return res
}
