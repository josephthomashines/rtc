#!/usr/bin/env python
import unittest
from main import *

#class SimpleTestCase(unittest.TestCase):
#    def setUp(self):
#        self.foo = Foo()
#        self.file = open( "blah", "r" )
#
#    def tearDown(self):
#        self.file.close()
#
#    def testA(self):
#        assert foo.bar() == 543, "bar() not calculating values correctly"

class TestPrimitive(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_constructor(self):
        p = Primitive(4.3,-4.2,3.1,1.0)
        assert \
            (p.get_x() == 4.3) and \
            (p.get_y() == -4.2) and \
            (p.get_z() == 3.1) and \
            (p.get_w() == 1.0), \
            "Can create a point primitive correctly"
        p = Primitive(4.3,-4.2,3.1,0.0)
        assert \
            (p.get_x() == 4.3) and \
            (p.get_y() == -4.2) and \
            (p.get_z() == 3.1) and \
            (p.get_w() == 0.0), \
            "Can create a vector primitive correctly"
        point = Point(4,-4,3)
        assert \
            (point.get_v() == [4,-4,3,1]), \
            "Can use Point constructor"
        vector = Vector(4,-4,3)
        assert \
            (vector.get_v() == [4,-4,3,0]), \
            "Can use Vector constructor"
    def test_operations(self):
        a1 = Point(3,-2,5)
        a2 = Vector(-2,3,1)
        assert \
            (a1+a2 == Point(1,1,6)), \
            "Can add two primitives"


if __name__ == "__main__":
    unittest.main()

