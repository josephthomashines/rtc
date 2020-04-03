module TestSphere where

import Matrix
import Sphere
import Transform

import Test.HUnit

testMakeSphere :: Test
testMakeSphere =
  TestList [TestCase (assertEqual "Sphere ID"
                     (1)
                     (sphereId s))
           ,TestCase (assertEqual "Sphere default translate"
                     (True)
                     (matrixEqual (makeIdentity 4) (translate s)))
           ,TestCase (assertEqual "Sphere default transform"
                     (True)
                     (matrixEqual (makeIdentity 4) (transform s)))
           ]
  where
    s = makeSphere 1

testSphereTransform :: Test
testSphereTransform =
  TestList [TestCase (assertEqual "Sphere Translation"
                     (True)
                     (matrixEqual (tr) (translate s1)))
           ,TestCase (assertEqual "Sphere Scale"
                     (True)
                     (matrixEqual (sc) (transform s2)))
           ,TestCase (assertEqual "Sphere Rotate"
                     (True)
                     (matrixEqual (ro) (transform s3)))
           ,TestCase (assertEqual "Sphere Shear"
                     (True)
                     (matrixEqual (sh) (transform s4)))
           ]
  where
    s = makeSphere 1
    tr = makeTranslation 2 3 4
    sc = makeScale 1 2 3
    ro = makeRotX 3
    sh = makeShear 7 8 9 1 2 3
    s1 = sphereTranslate s tr
    s2 = sphereTransform s1 sc
    s3 = sphereTransform s1 ro
    s4 = sphereTransform s1 sh

sphereTests = [testMakeSphere
              ,testSphereTransform
              ]
