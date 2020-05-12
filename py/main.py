#!/usr/bin/env python
import functools

POINT = 1
VECTOR = 0

def float_equals(a,b):
    ep = 1E-5
    return (abs(a-b) <= ep * abs(a))

class Primitive():
    def __init__(self,x=0,y=0,z=0,t=None):
        if t == None:
            raise Exception(
                "Primitive must have type specified \
                as either POINT or VECTOR")
        self._v = [x,y,z,t]

    def __str__(self):
        return f'{self._v}'
    def __eq__(self,other):
        return functools.reduce(
                lambda a,b: a==b,
                list(map(
                    lambda p: float_equals(*p),
                    zip(self._v,other.get_v()))),
                True)

    def get_x(self):
        return self._v[0]
    def get_y(self):
        return self._v[1]
    def get_z(self):
        return self._v[2]
    def get_w(self):
        return self._v[3]
    def get_v(self):
        return self._v

    def set_x(self,x):
        self._v[0] = x
    def set_y(self,y):
        self._v[1] = y
    def set_z(self,z):
        self._v[2] = z
    def set_w(self,w):
        self._v[3] = w
    def set_v(self,v):
        self._v = v

    def is_point(self):
        return self._v[3] == POINT
    def is_vector(self):
        return self._v[3] == VECTOR
    def is_valid(self):
        return (not self.is_point()) and (not self.is_vector())

    def __add__(self,other):
        return Primitive(
                *list(map(
                    lambda p: p[0] + p[1],
                    zip(self._v,other.get_v()))))
    def __sub__(self,other):
        return Primitive(
                *list(map(
                    lambda p: p[0] - p[1],
                    zip(self._v,other.get_v()))))
    def scale(self,s):
        p = Primitive(
                *list(map(
                    lambda x: x*s,
                self._v)))
        p.set_w(self.get_w())
        return p
    def negate(self):
        self._v = self.scale(-1).get_v()

class Point(Primitive):
    def __init__(self,x=0,y=0,z=0):
        super().__init__(x,y,z,POINT)
class Vector(Primitive):
    def __init__(self,x=0,y=0,z=0):
        super().__init__(x,y,z,VECTOR)

def main():
    p = Point(1,2,3)
    v = Vector(4,5,6)
    p.negate()
    print(p.scale(10))

if __name__ == "__main__":
    main()

