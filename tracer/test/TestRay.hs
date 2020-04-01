module TestRay where

import Point
import Ray
import Sphere

import Test.HUnit

testMakeRay :: Test
testMakeRay =
  TestList [TestCase (assertEqual "Origin"
                     (o)
                     (origin r))
           ,TestCase (assertEqual "Direction"
                     (d)
                     (direction r))
           ]
  where
    o = makePoint 1 2 3
    d = makeVector 4 5 6
    r = makeRay o d

testRayPosition :: Test
testRayPosition =
  TestList [TestCase (assertEqual "t 0"
                     (makePoint 2 3 4)
                     (rayPosition r 0))
           ,TestCase (assertEqual "t 1"
                     (makePoint 3 3 4)
                     (rayPosition r 1))
           ,TestCase (assertEqual "t -1"
                     (makePoint 1 3 4)
                     (rayPosition r (-1)))
           ,TestCase (assertEqual "t 2.5"
                     (makePoint 4.5 3 4)
                     (rayPosition r 2.5))
           ]
  where
    o = makePoint 2 3 4
    d = makeVector 1 0 0
    r = makeRay o d

testRaySphereIntersect :: Test
testRaySphereIntersect =
  TestList [TestCase (assertEqual "2 intersections count"
                     (2)
                     (length xs1))
           ,TestCase (assertEqual "2 intersections values"
                     ([4.0,6.0])
                     (xs1))
           ,TestCase (assertEqual "Tangent count"
                     (2)
                     (length xs2))
           ,TestCase (assertEqual "Tangent values"
                     ([5.0,5.0])
                     (xs2))
           ,TestCase (assertEqual "Miss count"
                     (0)
                     (length xs3))
           ,TestCase (assertEqual "Inside count"
                     (2)
                     (length xs4))
           ,TestCase (assertEqual "Inside values"
                     ([-1.0,1.0])
                     (xs4))
           ,TestCase (assertEqual "Wrong direction count"
                     (2)
                     (length xs5))
           ,TestCase (assertEqual "Wrong direction values"
                     ([-6.0,-4.0])
                     (xs5))
           ]
  where
    s = makeSphere 1
    r1 = makeRay (makePoint 0 0 (-5)) (makeVector 0 0 1)
    xs1 = raySphereIntersect r1 s
    r2 = makeRay (makePoint 0 1 (-5)) (makeVector 0 0 1)
    xs2 = raySphereIntersect r2 s
    r3 = makeRay (makePoint 0 2 (-5)) (makeVector 0 0 1)
    xs3 = raySphereIntersect r3 s
    r4 = makeRay (makePoint 0 0 0) (makeVector 0 0 1)
    xs4 = raySphereIntersect r4 s
    r5 = makeRay (makePoint 0 0 5) (makeVector 0 0 1)
    xs5 = raySphereIntersect r5 s

testMakeIntersection :: Test
testMakeIntersection =
  TestList [TestCase (assertEqual "t"
                     (3.5)
                     (t i))
           ,TestCase (assertEqual "object"
                     (s)
                     (object i))
           ]
  where
    s = makeSphere 1
    i = makeIntersection (3.5) (s)


rayTests = [testMakeRay
           ,testRayPosition
           ,testRaySphereIntersect
           ,testMakeIntersection
           ]
