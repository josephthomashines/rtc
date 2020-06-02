package main

import "testing"

func TestNewPrimitive(t *testing.T) {
	prim := newPrimitive(1, 2, 3, 4)

	if prim.x != 1 ||
		prim.y != 2 ||
		prim.z != 3 ||
		prim.w != 4 {
		t.Error("New primitive did not correctly set values")
	}

  point := newPoint(1,2,3)
  if point.x != 1 ||
  point.y != 2 ||
  point.z != 3 ||
  point.w != POINT_W {
		t.Error("New point did not correctly set values")
  }

  vector := newVector(1,2,3)
  if vector.x != 1 ||
  vector.y != 2 ||
  vector.z != 3 ||
  vector.w != VECTOR_W {
		t.Error("New vector did not correctly set values")
  }

  if !prim.Equals(prim) ||
  !point.Equals(point) ||
  !vector.Equals(vector) {
	  t.Error("Primitive equality failed")
  }
}

func TestAddPrimitives(t *testing.T) {
  a1 := newPrimitive(3,-2,5,1)
  a2 := newPrimitive(-2,3,1,0)
  res, err := addPrimitives(a1,a2)

  if err != nil {
    t.Error("Primitive add failed")
  }

  exp := newPrimitive(1,1,6,1)
  if !res.Equals(exp) {
    t.Errorf("%s + %s should be %s, got %s",a1,a2,exp,res)
  }

  a1 = newPoint(1,2,3)
  a2 = newPoint(1,2,3)
  _, err = addPrimitives(a1,a2)

  if err == nil {
    t.Error("Should error when adding points")
  }
}

func TestSubPrimitives(t *testing.T) {
  p1 := newPoint(3,2,1)
  p2 := newPoint(5,6,7)
  res, err := subPrimitives(p1,p2)

  if err != nil {
    t.Error("Primitive sub failed")
  }

  exp := newVector(-2,-4,-6)
  if !res.Equals(exp) {
    t.Errorf("%s - %s should be %s, got %s",p1,p2,exp,res)
  }

  p := p1
  v := newVector(5,6,7)
  res, err = subPrimitives(p,v)

  if err != nil {
    t.Error("Primitive sub failed")
  }

  exp = newPoint(-2,-4,-6)
  if !res.Equals(exp) {
    t.Errorf("%s - %s should be %s, got %s",p1,p2,exp,res)
  }

  v1 := newVector(3,2,1)
  v2 := v
  res, err = subPrimitives(v1,v2)

  exp = newVector(-2,-4,-6)
  if err != nil {
    t.Error("Primitive sub failed")
  }

  if !res.Equals(exp) {
    t.Errorf("%s - %s should be %s, got %s",p1,p2,exp,res)
  }

  _, err = subPrimitives(v,p)

  if err == nil {
    t.Error("Should error when vector - point")
  }
}
