module TestTransform where

import Point
import Matrix
import Transform

import Test.HUnit

testTranslation :: Test
testTranslation =
  TestList [TestCase (assertEqual "Basic point translation"
                     (True)
                     (matrixEqual e1 c1))
           ,TestCase (assertEqual "Inverse of translation matrix"
                     (True)
                     (matrixEqual e2 c2))
           ,TestCase (assertEqual "Vectors cannot be translated"
                     (True)
                     (matrixEqual v $ matrixMult t v))
           ]
  where
    t = makeTranslation 5 (-3) 2
    p = makePointMatrix (-3) 4 5
    e1 = makePointMatrix 2 1 7
    c1 = matrixMult t p
    e2 = makePointMatrix (-8) 7 3
    c2 = matrixMult (matrixInverse t) p
    v = makeVectorMatrix (-3) 4 5

testScale :: Test
testScale =
  TestList [TestCase (assertEqual "Basic scaling"
                     (True)
                     (matrixEqual e1 c1))
           ,TestCase (assertEqual "Shrinking"
                     (True)
                     (matrixEqual e2 c2))
           ,TestCase (assertEqual "Reflection"
                     (True)
                     (matrixEqual e3 c3))
           ]
  where
    t = makeScale 2 3 4
    v = makeVectorMatrix (-4) 6 8
    e1 = makeVectorMatrix (-8) 18 32
    c1 = matrixMult t v
    e2 = makeVectorMatrix (-2) 2 2
    c2 = matrixMult (matrixInverse t) v
    r = makeScale (-1) 1 1
    p = makePointMatrix 2 3 4
    e3 = makePointMatrix (-2) 3 4
    c3 = matrixMult r p

testRotation :: Test
testRotation =
  TestList [TestCase (assertEqual "Half quarter x"
                     (True)
                     (matrixEqual ex1 $ matrixMult rhx px))
           ,TestCase (assertEqual "Full quarter x"
                     (True)
                     (matrixEqual ex2 $ matrixMult rfx px))
           ,TestCase (assertEqual "Inverse half quarter x"
                     (True)
                     (matrixEqual ex3 $ matrixMult rihx px))
           ,TestCase (assertEqual "Half quarter y"
                     (True)
                     (matrixEqual ey1 $ matrixMult rhy py))
           ,TestCase (assertEqual "Full quarter y"
                     (True)
                     (matrixEqual ey2 $ matrixMult rfy py))
           ,TestCase (assertEqual "Half quarter z"
                     (True)
                     (matrixEqual ez1 $ matrixMult rhz pz))
           ,TestCase (assertEqual "Full quarter z"
                     (True)
                     (matrixEqual ez2 $ matrixMult rfz pz))
           ]
  where
    px = makePointMatrix 0 1 0
    rhx = makeRotX $ pi/4
    rfx = makeRotX $ pi/2
    rihx = matrixInverse $ makeRotX $ pi/4
    ex1 = makePointMatrix 0 ((sqrt 2)/2) ((sqrt 2)/2)
    ex2 = makePointMatrix 0 0 1
    ex3 = makePointMatrix 0 ((sqrt 2)/2) ((sqrt 2)/(-2))
    py = makePointMatrix 0 0 1
    rhy = makeRotY $ pi/4
    rfy = makeRotY $ pi/2
    ey1 = makePointMatrix ((sqrt 2)/2) 0 ((sqrt 2)/2)
    ey2 = makePointMatrix 1 0 0
    pz = makePointMatrix 0 1 0
    rhz = makeRotZ $ pi/4
    rfz = makeRotZ $ pi/2
    ez1 = makePointMatrix (-1 * (sqrt 2)/2) ((sqrt 2)/2) 0
    ez2 = makePointMatrix (-1) 0 0

testShear :: Test
testShear =
  TestList [TestCase (assertEqual "xy"
                     (True)
                     (matrixEqual (makePointMatrix 5 3 4) (matrixMult s1 p)))
           ,TestCase (assertEqual "xz"
                     (True)
                     (matrixEqual (makePointMatrix 6 3 4) (matrixMult s2 p)))
           ,TestCase (assertEqual "yx"
                     (True)
                     (matrixEqual (makePointMatrix 2 5 4) (matrixMult s3 p)))
           ,TestCase (assertEqual "yz"
                     (True)
                     (matrixEqual (makePointMatrix 2 7 4) (matrixMult s4 p)))
           ,TestCase (assertEqual "zx"
                     (True)
                     (matrixEqual (makePointMatrix 2 3 6) (matrixMult s5 p)))
           ,TestCase (assertEqual "zy"
                     (True)
                     (matrixEqual (makePointMatrix 2 3 7) (matrixMult s6 p)))
           ]
  where
    p = makePointMatrix 2 3 4
    s1 = makeShear 1 0 0 0 0 0
    s2 = makeShear 0 1 0 0 0 0
    s3 = makeShear 0 0 1 0 0 0
    s4 = makeShear 0 0 0 1 0 0
    s5 = makeShear 0 0 0 0 1 0
    s6 = makeShear 0 0 0 0 0 1

testSequence :: Test
testSequence =
  TestList [TestCase (assertEqual "p2"
                     (True)
                     (matrixEqual p2 e2))
           ,TestCase (assertEqual "p3"
                     (True)
                     (matrixEqual p3 e3))
           ,TestCase (assertEqual "p4"
                     (True)
                     (matrixEqual p4 e4))
           ,TestCase (assertEqual "sequence"
                     (True)
                     (matrixEqual tp etp))
           ]
  where
    a = makeRotX $ pi/2
    b = makeScale 5 5 5
    c = makeTranslation 10 5 7
    p = makePointMatrix 1 0 1
    p2 = matrixMult a p
    e2 = makePointMatrix 1 (-1) 0
    p3 = matrixMult b p2
    e3 = makePointMatrix 5 (-5) 0
    p4 = matrixMult c p3
    e4 = makePointMatrix 15 0 7
    t = matrixMult c $ matrixMult b a
    tp = matrixMult t p
    etp = makePointMatrix 15 0 7

transformTests = [testTranslation
                 ,testScale
                 ,testRotation
                 ,testShear
                 ,testSequence
                 ]
