module TestPoint where

import Test.HUnit
import Point

testMakePoint :: Test
testMakePoint =
  TestList [TestCase (assertEqual "Make point"
                     (makePoint 1 2 3) (Point 1.0 2.0 3.0 1.0))
           ]

testMakeVector :: Test
testMakeVector =
  TestList [TestCase (assertEqual "Make vector"
                     (makeVector 1 2 3) (Point 1.0 2.0 3.0 0.0))
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
    e = Point 0 0 0 2
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
    e = Point 0 0 0 2
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
    e = Point 0 0 0 2
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
    e = Point 0 0 0 2

testAddPoints :: Test
testAddPoints =
  TestList [TestCase (assertEqual "Vector + Vector"
                     (addPoints v v) (Point 2 4 6 0))
           ,TestCase (assertEqual "Vector + Point"
                     (addPoints v p) (Point 4 4 4 1))
           ,TestCase (assertEqual "Point + Vector"
                     (addPoints p v) (Point 4 4 4 1))
           ,TestCase (assertEqual "Point + Point"
                     (isErr $ addPoints p p) (True))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testSubPoints :: Test
testSubPoints =
  TestList [TestCase (assertEqual "vector - vector"
                     (subPoints v v) (Point 0 0 0 0))
           ,TestCase (assertEqual "vector - point"
                     (isErr $ subPoints v p) (True))
           ,TestCase (assertEqual "point - vector"
                     (subPoints p v) (Point 2 0 (-2) 1))
           ,TestCase (assertEqual "point - point"
                     (subPoints p p) (Point 0 0 0 0))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testScalePoint :: Test
testScalePoint =
  TestList [TestCase (assertEqual "Positive Vector"
                     (scalePoint 10 v) (Point 10 20 30 0))
           ,TestCase (assertEqual "Negative Vector"
                     (scalePoint (-5) v) (Point (-5) (-10) (-15) 0))
           ,TestCase (assertEqual "Zero Vector"
                     (scalePoint 0 v) (Point 0 0 0 0))
           ,TestCase (assertEqual "Positive Point"
                     (scalePoint 10 p) (Point 30 20 10 1))
           ,TestCase (assertEqual "Negative Point"
                     (scalePoint (-5) p) (Point (-15) (-10) (-5) 1))
           ,TestCase (assertEqual "Zero Point"
                     (scalePoint 0 p) (Point 0 0 0 1))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testDivPoint :: Test
testDivPoint =
  TestList [TestCase (assertEqual "Vector"
                     (divPoint 2 v) (Point 5 10 15 0))
           ,TestCase (assertEqual "Point"
                     (divPoint 5 p) (Point 6 4 2 1))
           ]
  where
    p = makePoint 30 20 10
    v = makeVector 10 20 30

testNegPoint :: Test
testNegPoint =
  TestList [TestCase (assertEqual "Vector"
                     (negPoint v) (Point (-10) (-20) (-30) 0))
           ,TestCase (assertEqual "Point"
                     (negPoint p) (Point (-30) (-20) (-10) 1))
           ,TestCase (assertEqual "Self inverting"
                     (negPoint $ negPoint p) (p))
           ]
  where
    p = makePoint 30 20 10
    v = makeVector 10 20 30

testMagnitudePoint :: Test
testMagnitudePoint =
  TestList [TestCase (assertEqual "Positive"
                     (magnitudePoint $ makeVector 2 4 6) (2 * (sqrt 14)))
           ,TestCase (assertEqual "Negative"
                     (magnitudePoint $ makeVector (-2) (-4) (-6)) (2 * (sqrt 14)))
           ]

testNormalizePoint :: Test
testNormalizePoint =
  TestList [TestCase (assertEqual "Positive"
                     (normalizePoint $ makeVector 4 2 (sqrt 5))
                     (makeVector (4/5) (2/5) ((sqrt 5) / 5)))
           ,TestCase (assertEqual "Negative"
                     (normalizePoint $ makeVector (-4) (-2) (sqrt 5))
                     (makeVector ((-4)/5) ((-2)/5) ((sqrt 5) / 5)))
           ,TestCase (assertEqual "One"
                     (normalizePoint $ makeVector 0 1 0)
                     (makeVector 0 1 0))
           ]

testDotPoints :: Test
testDotPoints =
  TestList [TestCase (assertEqual "Positive"
                     (dotPoints a b) (32))
           ,TestCase (assertEqual "Negative"
                     (dotPoints a c) (-2))
           ,TestCase (assertEqual "Order invariant"
                     (dotPoints a b) (dotPoints b a))
           ]
  where
    a = makeVector 1 2 3
    b = makeVector 4 5 6
    c = makeVector (-3) 2 (-1)

testCrossPoints :: Test
testCrossPoints =
  TestList [TestCase (assertEqual "Positive"
                     (crossPoints a b) (makeVector (-4) (8) (-4)))
           ,TestCase (assertEqual "Negative"
                     (crossPoints a c) (makeVector (-8) (-8) (8)))
           ]
  where
    a = makeVector 1 2 3
    b = makeVector 3 2 1
    c = makeVector (-3) 2 (-1)

pointTests :: [Test]
pointTests = [testMakePoint
             ,testMakeVector
             ,testGetX
             ,testGetY
             ,testGetZ
             ,testIsPoint
             ,testIsVector
             ,testAddPoints
             ,testSubPoints
             ,testScalePoint
             ,testDivPoint
             ,testNegPoint
             ,testMagnitudePoint
             ,testNormalizePoint
             ,testDotPoints
             ,testCrossPoints
             ]
