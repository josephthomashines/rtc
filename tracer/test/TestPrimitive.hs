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

testAddP :: Test
testAddP =
  TestList [TestCase (assertEqual "Vector + Vector"
                     (addP v v) (Primitive 2 4 6 0))
           ,TestCase (assertEqual "Vector + Point"
                     (addP v p) (Primitive 4 4 4 1))
           ,TestCase (assertEqual "Point + Vector"
                     (addP p v) (Primitive 4 4 4 1))
           ,TestCase (assertEqual "Point + Point"
                     (isErr $ addP p p) (True))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testSubP :: Test
testSubP =
  TestList [TestCase (assertEqual "vector - vector"
                     (subP v v) (Primitive 0 0 0 0))
           ,TestCase (assertEqual "vector - point"
                     (isErr $ subP v p) (True))
           ,TestCase (assertEqual "point - vector"
                     (subP p v) (Primitive 2 0 (-2) 1))
           ,TestCase (assertEqual "point - point"
                     (subP p p) (Primitive 0 0 0 0))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testScaleP :: Test
testScaleP =
  TestList [TestCase (assertEqual "Positive Vector"
                     (scaleP 10 v) (Primitive 10 20 30 0))
           ,TestCase (assertEqual "Negative Vector"
                     (scaleP (-5) v) (Primitive (-5) (-10) (-15) 0))
           ,TestCase (assertEqual "Zero Vector"
                     (scaleP 0 v) (Primitive 0 0 0 0))
           ,TestCase (assertEqual "Positive Point"
                     (scaleP 10 p) (Primitive 30 20 10 1))
           ,TestCase (assertEqual "Negative Point"
                     (scaleP (-5) p) (Primitive (-15) (-10) (-5) 1))
           ,TestCase (assertEqual "Zero Point"
                     (scaleP 0 p) (Primitive 0 0 0 1))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testDivP :: Test
testDivP =
  TestList [TestCase (assertEqual "Vector"
                     (divP 2 v) (Primitive 5 10 15 0))
           ,TestCase (assertEqual "Point"
                     (divP 5 p) (Primitive 6 4 2 1))
           ]
  where
    p = makePoint 30 20 10
    v = makeVector 10 20 30

testNegP :: Test
testNegP =
  TestList [TestCase (assertEqual "Vector"
                     (negP v) (Primitive (-10) (-20) (-30) 0))
           ,TestCase (assertEqual "Point"
                     (negP p) (Primitive (-30) (-20) (-10) 1))
           ,TestCase (assertEqual "Self inverting"
                     (negP $ negP p) (p))
           ]
  where
    p = makePoint 30 20 10
    v = makeVector 10 20 30

testMagnitudeP :: Test
testMagnitudeP =
  TestList [TestCase (assertEqual "Positive"
                     (magnitudeP $ makeVector 2 4 6) (2 * (sqrt 14)))
           ,TestCase (assertEqual "Negative"
                     (magnitudeP $ makeVector (-2) (-4) (-6)) (2 * (sqrt 14)))
           ]

testNormalizeP :: Test
testNormalizeP =
  TestList [TestCase (assertEqual "Positive"
                     (normalizeP $ makeVector 4 2 (sqrt 5))
                     (makeVector (4/5) (2/5) ((sqrt 5) / 5)))
           ,TestCase (assertEqual "Negative"
                     (normalizeP $ makeVector (-4) (-2) (sqrt 5))
                     (makeVector ((-4)/5) ((-2)/5) ((sqrt 5) / 5)))
           ,TestCase (assertEqual "One"
                     (normalizeP $ makeVector 0 1 0)
                     (makeVector 0 1 0))
           ]

testDotP :: Test
testDotP =
  TestList [TestCase (assertEqual "Positive"
                     (dotP a b) (32))
           ,TestCase (assertEqual "Negative"
                     (dotP a c) (-2))
           ,TestCase (assertEqual "Order invariant"
                     (dotP a b) (dotP b a))
           ]
  where
    a = makeVector 1 2 3
    b = makeVector 4 5 6
    c = makeVector (-3) 2 (-1)

testCrossP :: Test
testCrossP =
  TestList [TestCase (assertEqual "Positive"
                     (crossP a b) (makeVector (-4) (8) (-4)))
           ,TestCase (assertEqual "Negative"
                     (crossP a c) (makeVector (-8) (-8) (8)))
           ]
  where
    a = makeVector 1 2 3
    b = makeVector 3 2 1
    c = makeVector (-3) 2 (-1)

primitiveTests :: [Test]
primitiveTests = [testMakePoint
                 ,testMakeVector
                 ,testGetX
                 ,testGetY
                 ,testGetZ
                 ,testIsPoint
                 ,testIsVector
                 ,testAddP
                 ,testSubP
                 ,testScaleP
                 ,testDivP
                 ,testNegP
                 ,testMagnitudeP
                 ,testNormalizeP
                 ,testDotP
                 ,testCrossP
                 ]
