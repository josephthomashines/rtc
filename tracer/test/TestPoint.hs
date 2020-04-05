module TestPoint where

import Test.HUnit
import Point

testMakePoint :: Test
testMakePoint =
  TestList [TestCase (assertEqual "Make point"
                     (Point 1.0 2.0 3.0 1.0)
                     (makePoint 1 2 3)
                     )
           ]

testMakeVector :: Test
testMakeVector =
  TestList [TestCase (assertEqual "Make vector"
                     (Point 1.0 2.0 3.0 0.0)
                     (makeVector 1 2 3)
                     )
           ]

testGetX :: Test
testGetX =
  TestList [TestCase (assertEqual "Get x from point"
                     (3)
                     (x p)
                     )
           ,TestCase (assertEqual "Get x from vector"
                     (1)
                     (x v)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
testGetY :: Test
testGetY =
  TestList [TestCase (assertEqual "Get y from point"
                     (2)
                     (y p)
                     )
           ,TestCase (assertEqual "Get y from vector"
                     (2)
                     (y v)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
testGetZ :: Test
testGetZ =
  TestList [TestCase (assertEqual "Get z from point"
                     (1)
                     (z p)
                     )
           ,TestCase (assertEqual "Get z from vector"
                     (3)
                     (z v)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testIsPoint :: Test
testIsPoint =
  TestList [TestCase (assertEqual "Is point"
                     (True)
                     (isPoint p)
                     )
           ,TestCase (assertEqual "Is not point"
                     (False)
                     (isPoint v)
                     )
           ,TestCase (assertEqual "Is not point 2"
                     (False)
                     (isPoint e)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
    e = Point 0 0 0 2
testIsVector :: Test
testIsVector =
  TestList [TestCase (assertEqual "Is not vector"
                     (False)
                     (isVector p)
                     )
           ,TestCase (assertEqual "Is vector"
                     (True)
                     (isVector v)
                     )
           ,TestCase (assertEqual "Is not vector 2"
                     (False)
                     (isVector e)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
    e = Point 0 0 0 2
testIsErr :: Test
testIsErr =
  TestList [TestCase (assertEqual "Is not error"
                     (False)
                     (isErr p)
                     )
           ,TestCase (assertEqual "Is not error 2"
                     (False)
                     (isErr v)
                     )
           ,TestCase (assertEqual "Is error"
                     (True)
                     (isErr e)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
    e = Point 0 0 0 2
testIsValid :: Test
testIsValid =
  TestList [TestCase (assertEqual "Is valid"
                     (True)
                     (isValid p)
                     )
           ,TestCase (assertEqual "Is valid 2"
                     (True)
                     (isValid v)
                     )
           ,TestCase (assertEqual "Is not valid"
                     (False)
                     (isValid e)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
    e = Point 0 0 0 2

testAddPoints :: Test
testAddPoints =
  TestList [TestCase (assertEqual "Vector + Vector"
                     (Point 2 4 6 0)
                     (addPoints v v)
                     )
           ,TestCase (assertEqual "Vector + Point"
                     (Point 4 4 4 1)
                     (addPoints v p)
                     )
           ,TestCase (assertEqual "Point + Vector"
                     (Point 4 4 4 1)
                     (addPoints p v)
                     )
           ,TestCase (assertEqual "Point + Point"
                     (True)
                     (isErr $ addPoints p p)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testSubPoints :: Test
testSubPoints =
  TestList [TestCase (assertEqual "vector - vector"
                     (Point 0 0 0 0)
                     (subPoints v v)
                     )
           ,TestCase (assertEqual "vector - point"
                     (True)
                     (isErr $ subPoints v p)
                     )
           ,TestCase (assertEqual "point - vector"
                     (Point 2 0 (-2) 1)
                     (subPoints p v)
                     )
           ,TestCase (assertEqual "point - point"
                     (Point 0 0 0 0)
                     (subPoints p p)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testScalePoint :: Test
testScalePoint =
  TestList [TestCase (assertEqual "Positive Vector"
                     (Point 10 20 30 0)
                     (scalePoint 10 v)
                     )
           ,TestCase (assertEqual "Negative Vector"
                     (Point (-5) (-10) (-15) 0)
                     (scalePoint (-5) v)
                     )
           ,TestCase (assertEqual "Zero Vector"
                     (Point 0 0 0 0)
                     (scalePoint 0 v)
                     )
           ,TestCase (assertEqual "Positive Point"
                     (Point 30 20 10 1)
                     (scalePoint 10 p)
                     )
           ,TestCase (assertEqual "Negative Point"
                     (Point (-15) (-10) (-5) 1)
                     (scalePoint (-5) p)
                     )
           ,TestCase (assertEqual "Zero Point"
                     (Point 0 0 0 1)
                     (scalePoint 0 p)
                     )
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

testDivPoint :: Test
testDivPoint =
  TestList [TestCase (assertEqual "Vector"
                     (Point 5 10 15 0)
                     (divPoint 2 v)
                     )
           ,TestCase (assertEqual "Point"
                     (Point 6 4 2 1)
                     (divPoint 5 p)
                     )
           ]
  where
    p = makePoint 30 20 10
    v = makeVector 10 20 30

testNegPoint :: Test
testNegPoint =
  TestList [TestCase (assertEqual "Vector"
                     (Point (-10) (-20) (-30) 0)
                     (negPoint v)
                     )
           ,TestCase (assertEqual "Point"
                     (Point (-30) (-20) (-10) 1)
                     (negPoint p)
                     )
           ,TestCase (assertEqual "Self inverting"
                     (p)
                     (negPoint $ negPoint p)
                     )
           ]
  where
    p = makePoint 30 20 10
    v = makeVector 10 20 30

testMagnitudePoint :: Test
testMagnitudePoint =
  TestList [TestCase (assertEqual "Positive"
                     (2 * (sqrt 14))
                     (magnitudePoint $ makeVector 2 4 6)
                     )
           ,TestCase (assertEqual "Negative"
                     (2 * (sqrt 14))
                     (magnitudePoint $ makeVector (-2) (-4) (-6))
                     )
           ]

testNormalizePoint :: Test
testNormalizePoint =
  TestList [TestCase (assertEqual "Positive"
                     (makeVector (4/5) (2/5) ((sqrt 5) / 5))
                     (normalizePoint $ makeVector 4 2 (sqrt 5))
                     )
           ,TestCase (assertEqual "Negative"
                     (makeVector ((-4)/5) ((-2)/5) ((sqrt 5) / 5))
                     (normalizePoint $ makeVector (-4) (-2) (sqrt 5))
                     )
           ,TestCase (assertEqual "One"
                     (makeVector 0 1 0)
                     (normalizePoint $ makeVector 0 1 0)
                     )
           ]

testDotPoints :: Test
testDotPoints =
  TestList [TestCase (assertEqual "Positive"
                     (32)
                     (dotPoints a b)
                     )
           ,TestCase (assertEqual "Negative"
                     (-2)
                     (dotPoints a c)
                     )
           ,TestCase (assertEqual "Order invariant"
                     (dotPoints b a)
                     (dotPoints a b)
                     )
           ]
  where
    a = makeVector 1 2 3
    b = makeVector 4 5 6
    c = makeVector (-3) 2 (-1)

testCrossPoints :: Test
testCrossPoints =
  TestList [TestCase (assertEqual "Positive"
                     (makeVector (-4) (8) (-4))
                     (crossPoints a b)
                     )
           ,TestCase (assertEqual "Negative"
                     (makeVector (-8) (-8) (8))
                     (crossPoints a c)
                     )
           ]
  where
    a = makeVector 1 2 3
    b = makeVector 3 2 1
    c = makeVector (-3) 2 (-1)

testReflectVector :: Test
testReflectVector =
  TestList [TestCase (assertEqual "First reflect"
                     (makeVector 1 1 0)
                     (reflectVector n1 v1))
           ,TestCase (assertEqual "Second reflect"
                     (makeVector 1 0 0)
                     (reflectVector n2 v2))
           ]
  where
    v1 = makeVector 1 (-1) 0
    n1 = makeVector 0 1 0
    r2o2 = (sqrt 2)/2
    v2 = makeVector 0 (-1) 0
    n2 = makeVector r2o2 r2o2 0

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
             ,testReflectVector
             ]
