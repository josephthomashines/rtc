module TestRay where

import Point
import Ray
import Sphere
import Transform

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
                     (map (t) xs1))
           ,TestCase (assertEqual "Tangent count"
                     (2)
                     (length xs2))
           ,TestCase (assertEqual "Tangent values"
                     ([5.0,5.0])
                     (map (t) xs2))
           ,TestCase (assertEqual "Miss count"
                     (0)
                     (length xs3))
           ,TestCase (assertEqual "Inside count"
                     (2)
                     (length xs4))
           ,TestCase (assertEqual "Inside values"
                     ([-1.0,1.0])
                     (map (t) xs4))
           ,TestCase (assertEqual "Wrong direction count"
                     (2)
                     (length xs5))
           ,TestCase (assertEqual "Wrong direction values"
                     ([-6.0,-4.0])
                     (map (t) xs5))
           ,TestCase (assertEqual "Sets object"
                     ([s,s])
                     (map (object) xs1))
           ,TestCase (assertEqual "Scaled circle count"
                     (2)
                     (length xs6))
           ,TestCase (assertEqual "Scaled circle values"
                     ([3,7])
                     (map (t) xs6))
           ,TestCase (assertEqual "Translated circle miss"
                     (0)
                     (length xs7))
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
    s1 = sphereTransform s $ makeScale 2 2 2
    xs6 = raySphereIntersect r1 s1
    s2 = sphereTransform s $ makeTranslation 5 0 0
    xs7 = raySphereIntersect r1 s2

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

testHit :: Test
testHit =
  TestList [TestCase (assertEqual "Both positive"
                     (Just i1)
                     (hit xs1))
           ,TestCase (assertEqual "One negative"
                     (Just i2)
                     (hit xs2))
           ,TestCase (assertEqual "Both negative"
                     (Nothing)
                     (hit xs3))
           ,TestCase (assertEqual "More complex"
                     (Just ii4)
                     (hit xs4))
           ]
  where
    s = makeSphere 1
    i1 = makeIntersection 1 s
    i2 = makeIntersection 2 s
    i3 = makeIntersection (-1) s
    i4 = makeIntersection (-2) s
    xs1 = [i2, i1]
    xs2 = [i2, i3]
    xs3 = [i3, i4]
    ii1 = makeIntersection 5 s
    ii2 = makeIntersection 7 s
    ii3 = makeIntersection (-3) s
    ii4 = makeIntersection 2 s
    xs4 = [ii1,ii2,ii3,ii4]

testRayTransform :: Test
testRayTransform =
  TestList [TestCase (assertEqual "Translation origin"
                     (makePoint 4 6 8)
                     (origin r1))
           ,TestCase (assertEqual "Translation direction"
                     (makeVector 0 1 0)
                     (direction r1))
           ,TestCase (assertEqual "Scale origin"
                     (makePoint 2 6 12)
                     (origin r2))
           ,TestCase (assertEqual "Scale direction"
                     (makeVector 0 3 0)
                     (direction r2))
           ]
  where
    o = makePoint 1 2 3
    d = makeVector 0 1 0
    r = makeRay o d
    m = makeTranslation 3 4 5
    r1 = rayTranslate r m
    s = makeScale 2 3 4
    r2 = rayTransform r s

rayTests = [testMakeRay
           ,testRayPosition
           ,testRaySphereIntersect
           ,testMakeIntersection
           ,testHit
           ,testRayTransform
           ]
