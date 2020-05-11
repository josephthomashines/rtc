#!/usr/bin/env python
import unittest
import main

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
        pass

if __name__ == "__main__":
    unittest.main()

