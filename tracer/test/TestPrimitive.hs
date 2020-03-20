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
                     (getX p) (3))
           ,TestCase (assertEqual "Get x from vector"
                     (getX v) (1))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
testGetY :: Test
testGetY =
  TestList [TestCase (assertEqual "Get y from point"
                     (getY p) (2))
           ,TestCase (assertEqual "Get y from vector"
                     (getY v) (2))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
testGetZ :: Test
testGetZ =
  TestList [TestCase (assertEqual "Get z from point"
                     (getZ p) (1))
           ,TestCase (assertEqual "Get z from vector"
                     (getZ v) (3))
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
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3
testIsVector :: Test
testIsVector =
  TestList [TestCase (assertEqual "Is not vector"
                     (isVector p) (False))
           ,TestCase (assertEqual "Is vector"
                     (isVector v) (True))
           ]
  where
    p = makePoint 3 2 1
    v = makeVector 1 2 3

primitiveTests :: [Test]
primitiveTests = [testMakePoint
                 ,testMakeVector
                 ,testGetX
                 ,testGetY
                 ,testGetZ
                 ,testIsPoint
                 ,testIsVector
                 ]
