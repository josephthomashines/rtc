module TestPrimitive where

import Test.HUnit
import Primitive

testMakePoint :: Test
testMakePoint =
  TestList [TestCase (assertEqual "Make point"
                     (makePoint 1 2 3) (Primitive 1.0 2.0 3.0 1.0))
           ]

testMakeVector :: Test
testMakeVector =
  TestList [TestCase (assertEqual "Make vector"
                     (makeVector 1 2 3) (Primitive 1.0 2.0 3.0 0.0))
           ]

testGetX :: Test
testGetX =
  TestList [TestCase (assertEqual "Get x from point"
                     (x p) (3))
           ,TestCase (assertEqual "Get x from vector"
                     (x v) (1))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
testGetY :: Test
testGetY =
  TestList [TestCase (assertEqual "Get y from point"
                     (y p) (2))
           ,TestCase (assertEqual "Get y from vector"
                     (y v) (2))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
testGetZ :: Test
testGetZ =
  TestList [TestCase (assertEqual "Get z from point"
                     (z p) (1))
           ,TestCase (assertEqual "Get z from vector"
                     (z v) (3))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testIsPoint :: Test
testIsPoint =
  TestList [TestCase (assertEqual "Is point"
                     (isPoint p) (True))
           ,TestCase (assertEqual "Is not point"
                     (isPoint v) (False))
           ,TestCase (assertEqual "Is not point 2"
                     (isPoint e) (False))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
    e = makeErr
testIsVector :: Test
testIsVector =
  TestList [TestCase (assertEqual "Is not vector"
                     (isVector p) (False))
           ,TestCase (assertEqual "Is vector"
                     (isVector v) (True))
           ,TestCase (assertEqual "Is not vector 2"
                     (isVector e) (False))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
    e = makeErr
testIsErr :: Test
testIsErr =
  TestList [TestCase (assertEqual "Is not error"
                     (isErr p) (False))
           ,TestCase (assertEqual "Is not error 2"
                     (isErr v) (False))
           ,TestCase (assertEqual "Is error"
                     (isErr e) (True))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
    e = makeErr
testIsValid :: Test
testIsValid =
  TestList [TestCase (assertEqual "Is valid"
                     (isValid p) (True))
           ,TestCase (assertEqual "Is valid 2"
                     (isValid v) (True))
           ,TestCase (assertEqual "Is not valid"
                     (isValid e) (False))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
    e = makeErr

testAddPrimitives :: Test
testAddPrimitives =
  TestList [TestCase (assertEqual "Vector + Vector"
                     (addPrimitives v v) (Primitive 2 4 6 0))
           ,TestCase (assertEqual "Vector + Point"
                     (addPrimitives v p) (Primitive 4 4 4 1))
           ,TestCase (assertEqual "Point + Vector"
                     (addPrimitives p v) (Primitive 4 4 4 1))
           ,TestCase (assertEqual "Point + Point"
                     (isErr $ addPrimitives p p) (True))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testSubPrimitives :: Test
testSubPrimitives =
  TestList [TestCase (assertEqual "vector - vector"
                     (subPrimitives v v) (Primitive 0 0 0 0))
           ,TestCase (assertEqual "vector - point"
                     (isErr $ subPrimitives v p) (True))
           ,TestCase (assertEqual "point - vector"
                     (subPrimitives p v) (Primitive 2 0 (-2) 1))
           ,TestCase (assertEqual "point - point"
                     (subPrimitives p p) (Primitive 0 0 0 0))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testMultPrimitive :: Test
testMultPrimitive =
  TestList [TestCase (assertEqual "Positive Vector"
                     (multPrimitive 10 v) (Primitive 10 20 30 0))
           ,TestCase (assertEqual "Negative Vector"
                     (multPrimitive (-5) v) (Primitive (-5) (-10) (-15) 0))
           ,TestCase (assertEqual "Zero Vector"
                     (multPrimitive 0 v) (Primitive 0 0 0 0))
           ,TestCase (assertEqual "Positive Point"
                     (multPrimitive 10 p) (Primitive 30 20 10 1))
           ,TestCase (assertEqual "Negative Point"
                     (multPrimitive (-5) p) (Primitive (-15) (-10) (-5) 1))
           ,TestCase (assertEqual "Zero Point"
                     (multPrimitive 0 p) (Primitive 0 0 0 1))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testDividePrimitive :: Test
testDividePrimitive =
  TestList [TestCase (assertEqual "Vector"
                     (dividePrimitive 2 v) (Primitive 5 10 15 0))
           ,TestCase (assertEqual "Point"
                     (dividePrimitive 5 p) (Primitive 6 4 2 1))
           ]
  where
    p = makePoint 30 20 10
    v = makeVector 10 20 30

testNegatePrimitive :: Test
testNegatePrimitive =
  TestList [TestCase (assertEqual "Vector"
                     (negatePrimitive v) (Primitive (-10) (-20) (-30) 0))
           ,TestCase (assertEqual "Point"
                     (negatePrimitive p) (Primitive (-30) (-20) (-10) 1))
           ,TestCase (assertEqual "Self inverting"
                     (negatePrimitive $ negatePrimitive p) (p))
           ]
  where
    p = makePoint 30 20 10
    v = makeVector 10 20 30

testMagnitudePrimitive :: Test
testMagnitudePrimitive =
  TestList [TestCase (assertEqual "Positive"
                     (magnitudePrimitive $ makeVector 2 4 6) (2 * (sqrt 14)))
           ,TestCase (assertEqual "Negative"
                     (magnitudePrimitive $ makeVector (-2) (-4) (-6)) (2 * (sqrt 14)))
           ]

testNormalizePrimitive :: Test
testNormalizePrimitive =
  TestList [TestCase (assertEqual "Positive"
                     (normalizePrimitive $ makeVector 4 2 (sqrt 5))
                     (makeVector (4/5) (2/5) ((sqrt 5) / 5)))
           ,TestCase (assertEqual "Negative"
                     (normalizePrimitive $ makeVector (-4) (-2) (sqrt 5))
                     (makeVector ((-4)/5) ((-2)/5) ((sqrt 5) / 5)))
           ,TestCase (assertEqual "One"
                     (normalizePrimitive $ makeVector 0 1 0)
                     (makeVector 0 1 0))
           ]

testDotPrimitive :: Test
testDotPrimitive =
  TestList [TestCase (assertEqual "Positive"
                     (dotPrimitive a b) (32))
           ,TestCase (assertEqual "Negative"
                     (dotPrimitive a c) (-2))
           ,TestCase (assertEqual "Order invariant"
                     (dotPrimitive a b) (dotPrimitive b a))
           ]
  where
    a = makeVector 1 2 3
    b = makeVector 4 5 6
    c = makeVector (-3) 2 (-1)

testCrossPrimitive :: Test
testCrossPrimitive =
  TestList [TestCase (assertEqual "Positive"
                     (1) (1))
           ]

primitiveTests :: [Test]
primitiveTests = [testMakePoint
                 ,testMakeVector
                 ,testGetX
                 ,testGetY
                 ,testGetZ
                 ,testIsPoint
                 ,testIsVector
                 ,testAddPrimitives
                 ,testSubPrimitives
                 ,testMultPrimitive
                 ,testDividePrimitive
                 ,testNegatePrimitive
                 ,testMagnitudePrimitive
                 ,testNormalizePrimitive
                 ,testDotPrimitive
                 ,testCrossPrimitive
                 ]
