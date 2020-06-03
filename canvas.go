package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

type coord struct {
	x, y int
}

type pixels = map[coord]*color
type canvas struct {
	width, height int
	pxs           pixels
}

func NewCoord(x, y int) *coord {
	return &coord{x, y}
}

func NewCanvas(w, h int) *canvas {
	pxs := make(pixels)

	col := NewColor(0, 0, 0)

	for i := 0; i < h; i++ {
		for j := 0; j < w; j++ {
			pxs[coord{j, i}] = col
		}
	}

	return &canvas{w, h, pxs}
}

func (c *canvas) GetPixel(x, y int) *color {
	return c.pxs[coord{x, y}]
}

func (c *canvas) WritePixel(x, y int, col *color) {
	if x >= 0 && x < c.width &&
		y >= 0 && y < c.height {
		c.pxs[coord{x, y}] = col
	}
}

func (c *canvas) ToPPM() string {
	header := fmt.Sprintf(
		"P3\n%d %d\n255\n\n",
		c.width,
		c.height,
	)

	var bodyBuidler strings.Builder
	count := 0
	for i := 0; i < c.height; i++ {
		for j := 0; j < c.width; j++ {
			col := c.GetPixel(j, i)
			r := strconv.Itoa(Clip(0, 255, int(col.r*255))) + " "
			g := strconv.Itoa(Clip(0, 255, int(col.g*255))) + " "
			b := strconv.Itoa(Clip(0, 255, int(col.b*255))) + " "

			bodyBuidler.WriteString(r)
			bodyBuidler.WriteString(g)
			bodyBuidler.WriteString(b)
			if count > 65 {
				bodyBuidler.WriteString("\n")
				count = 0
			}

			count += 12
		}
	}

	return header + bodyBuidler.String() + "\n"
}

func (c *canvas) Save(filename string) error {
	f, err := os.Create(filename)
	if err != nil {
		return err
	}

	s := c.ToPPM()
	_, err = f.WriteString(s)
	defer f.Close()
	if err != nil {
		fmt.Println(err)
		f.Close()
		return err
	}

	return nil
}

// ---------------------------------------------------------------------------
// Demo

func DemoCanvas() {
	tempVelocity, err := NewVector(1, 1.8, 0).Normalize()
	tempVelocity = tempVelocity.Scale(11.25)

	if err != nil {
		panic(err)
	}

	proj := &DemoProjectile{
		NewPoint(0, 1, 0),
		tempVelocity,
	}
	env := &DemoEnvironment{
		NewVector(0, -0.1, 0),
		NewVector(-0.01, 0, 0),
	}

	c := NewCanvas(900, 550)
	col := NewColor(1, 1, 0)

	for proj.position.y > 0 {
		x := int(proj.position.x)
		y := int(proj.position.y)
		c.WritePixel(x, 550-y, col)
		DemoTick(env, proj)
	}

	proj.position.y = 0
	fmt.Println(proj.position)
	if err := c.Save("./DemoCanvas.ppm"); err != nil {
		panic(err)
	}
}
