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
    p = matrixFromPoint $ makePoint (-3) 4 5
    e1 = matrixFromPoint $ makePoint 2 1 7
    c1 = matrixMult t p
    e2 = matrixFromPoint $ makePoint (-8) 7 3
    c2 = matrixMult (matrixInverse t) p
    v = matrixFromPoint $ makeVector (-3) 4 5

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
    v = matrixFromPoint $ makeVector (-4) 6 8
    e1 = matrixFromPoint $ makeVector (-8) 18 32
    c1 = matrixMult t v
    e2 = matrixFromPoint $ makeVector (-2) 2 2
    c2 = matrixMult (matrixInverse t) v
    r = makeScale (-1) 1 1
    p = matrixFromPoint $ makePoint 2 3 4
    e3 = matrixFromPoint $ makePoint (-2) 3 4
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
    px = matrixFromPoint $ makePoint 0 1 0
    rhx = makeRotX $ pi/4
    rfx = makeRotX $ pi/2
    rihx = matrixInverse $ makeRotX $ pi/4
    ex1 = matrixFromPoint $ makePoint 0 ((sqrt 2)/2) ((sqrt 2)/2)
    ex2 = matrixFromPoint $ makePoint 0 0 1
    ex3 = matrixFromPoint $ makePoint 0 ((sqrt 2)/2) ((sqrt 2)/(-2))
    py = matrixFromPoint $ makePoint 0 0 1
    rhy = makeRotY $ pi/4
    rfy = makeRotY $ pi/2
    ey1 = matrixFromPoint $ makePoint ((sqrt 2)/2) 0 ((sqrt 2)/2)
    ey2 = matrixFromPoint $ makePoint 1 0 0
    pz = matrixFromPoint $ makePoint 0 1 0
    rhz = makeRotZ $ pi/4
    rfz = makeRotZ $ pi/2
    ez1 = matrixFromPoint $ makePoint (-1 * (sqrt 2)/2) ((sqrt 2)/2) 0
    ez2 = matrixFromPoint $ makePoint (-1) 0 0

transformTests = [testTranslation
                 ,testScale
                 ,testRotation
                 ]
