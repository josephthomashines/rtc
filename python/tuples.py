#!/usr/bin/env python
import math
import unittest

from utils import req

class Tuple:
    def __init__(s,x,y,z,w):
        s.x = x
        s.y = y
        s.z = z
        s.w = w

    def isPoint(s):
        return req(s.w,1)

    def isVector(s):
        return req(s.w,0)

    def __str__(s):
        return "[{:6.2f} {:6.2f} {:6.2f} {:6.2f}]".format(s.x,s.y,s.z,s.w)

    def __repr__(s):
        return str(s)

    def __eq__(s, o):
        return req(s.x,o.x) and req(s.y,o.y) and req(s.z,o.z) and req(s.w,o.w)

    def __add__(s, o):
        return Tuple(
            s.x + o.x,
            s.y + o.y,
            s.z + o.z,
            s.w + o.w,
        )

    def __sub__(s, o):
        return Tuple(
            s.x - o.x,
            s.y - o.y,
            s.z - o.z,
            s.w - o.w,
        )

    def __neg__(s):
        return Tuple(
            -s.x,
            -s.y,
            -s.z,
            -s.w,
        )

    def __mul__(s, o):
        return Tuple(
            s.x * o,
            s.y * o,
            s.z * o,
            s.w * o,
        )

    def __truediv__(s, o):
        return Tuple(
            s.x / o,
            s.y / o,
            s.z / o,
            s.w / o,
        )

    def magnitude(s):
        return math.sqrt(
            (s.x ** 2) +
            (s.y ** 2) +
            (s.z ** 2) +
            (s.w ** 2)
        )

    def normalize(s):
        return s / s.magnitude()

    @staticmethod
    def dot(s, o):
        return s.x * o.x + s.y * o.y + s.z * o.z + s.w * o.w

    @staticmethod
    def cross(s, o):
        return Vector(
            s.y*o.z - s.z*o.y,
            s.z*o.x - s.x*o.z,
            s.x*o.y - s.y*o.x,
        )


def Point(x,y,z):
    return Tuple(x,y,z,1)

def Vector(x,y,z):
    return Tuple(x,y,z,0)


class TestTuples(unittest.TestCase):
    def test_tuple_w_1(self):
        a = Tuple(4.3,-4.2,3.1,1.0)
        self.assertEqual(a.x,4.3)
        self.assertEqual(a.y,-4.2)
        self.assertEqual(a.z,3.1)
        self.assertEqual(a.w,1.0)
        self.assertTrue(a.isPoint())
        self.assertFalse(a.isVector())

    def test_tuple_w_0(self):
        a = Tuple(4.3,-4.2,3.1,0.0)
        self.assertEqual(a.x,4.3)
        self.assertEqual(a.y,-4.2)
        self.assertEqual(a.z,3.1)
        self.assertEqual(a.w,0.0)
        self.assertFalse(a.isPoint())
        self.assertTrue(a.isVector())

    def test_point_creates(self):
        p = Point(4,-4,3)
        self.assertEqual(p,Tuple(4,-4,3,1))

    def test_vector_creates(self):
        p = Vector(4,-4,3)
        self.assertEqual(p,Tuple(4,-4,3,0))

    def test_add_tuples(self):
        a1 = Tuple(3,-2,5,1)
        a2 = Tuple(-2,3,1,0)
        self.assertEqual(a1+a2, Tuple(1,1,6,1))

    def test_sub_points(self):
        p1 = Point(3,2,1)
        p2 = Point(5,6,7)
        self.assertEqual(p1-p2, Vector(-2,-4,-6))

    def test_sub_point_vector(self):
        p = Point(3,2,1)
        v = Vector(5,6,7)
        self.assertEqual(p-v, Point(-2,-4,-6))

    def test_sub_vector(self):
        v1 = Vector(3,2,1)
        v2 = Vector(5,6,7)
        self.assertEqual(v1-v2, Vector(-2,-4,-6))

    def test_sub_zero(self):
        zero = Vector(0,0,0)
        v = Vector(1,-2,3)
        self.assertEqual(zero-v, Vector(-1,2,-3))

    def test_neg_tuple(self):
        a = Tuple(1,-2,3,-4)
        self.assertEqual(-a,Tuple(-1,2,-3,4))

    def test_scale(self):
        a = Tuple(1,-2,3,-4)
        self.assertEqual(a*3.5,Tuple(3.5,-7,10.5,-14))
        self.assertEqual(a*0.5,Tuple(0.5,-1,1.5,-2))
        self.assertEqual(a/2,Tuple(0.5,-1,1.5,-2))

    def test_magnitude(self):
        v = Vector(1,0,0)
        self.assertEqual(v.magnitude(),1)

        v = Vector(0,1,0)
        self.assertEqual(v.magnitude(),1)

        v = Vector(0,0,1)
        self.assertEqual(v.magnitude(),1)

        v = Vector(1,2,3)
        self.assertEqual(v.magnitude(),math.sqrt(14))

        v = Vector(-1,-2,-3)
        self.assertEqual(v.magnitude(),math.sqrt(14))

    def test_normalize(self):
        v = Vector(4,0,0)
        self.assertEqual(v.normalize(), Vector(1,0,0))

        v = Vector(1,2,3)
        self.assertEqual(v.normalize(), Vector(
            1/math.sqrt(14),2/math.sqrt(14),3/math.sqrt(14)
        ))
        self.assertEqual(v.normalize().magnitude(), 1)

    def test_dot(self):
        a = Vector(1,2,3)
        b = Vector(2,3,4)
        self.assertEqual(Tuple.dot(a,b), 20)

    def test_cross(self):
        a = Vector(1,2,3)
        b = Vector(2,3,4)
        self.assertEqual(Tuple.cross(a,b), Vector(-1,2,-1))
        self.assertEqual(Tuple.cross(b,a), Vector(1,-2,1))

def demo_tuples(*args):
    class Projectile:
        def __init__(self, position, velocity):
            self.position = position
            self.velocity = velocity

    class Environment:
        def __init__(self, gravity, wind):
            self.gravity = gravity
            self.wind = wind

    def tick(env,prj):
        position = prj.position + prj.velocity
        velocity = prj.velocity + env.gravity + env.wind
        return Projectile(position, velocity)

    def print_prj(p):
        print("{:6.2f} {:6.2f}".format(p.position.x, p.position.y))

    p = Projectile(Point(0,1,0), Vector(1,1,0).normalize())
    e = Environment(Vector(0,-0.1,0), Vector(-0.01,0,0))

    while p.position.y > 0:
        print_prj(p)
        p = tick(e,p)

    print("Hit!")
    print_prj(p)
