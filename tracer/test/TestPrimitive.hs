module TestPrimitive where

import Test.HUnit
import Primitive

testPointConstructor :: Test
testPointConstructor =
  TestCase (assertEqual "Point constructor." 1 1)

primitiveTests :: [Test]
primitiveTests = [testPointConstructor]
