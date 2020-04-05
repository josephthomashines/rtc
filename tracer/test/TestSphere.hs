module TestSphere where

import Material
import Matrix
import Point
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

testSphereNormalAt :: Test
testSphereNormalAt =
  TestList [TestCase (assertEqual "Normal 1"
                     (makeVector 1 0 0)
                     (sphereNormalAt s $ makePoint 1 0 0))
           ,TestCase (assertEqual "Normal 2"
                     (makeVector 0 1 0)
                     (sphereNormalAt s $ makePoint 0 1 0))
           ,TestCase (assertEqual "Normal 3"
                     (makeVector 0 0 1)
                     (sphereNormalAt s $ makePoint 0 0 1))
           ,TestCase (assertEqual "Normal 4"
                     (makeVector r3o3 r3o3 r3o3)
                     (sphereNormalAt s $ makePoint r3o3 r3o3 r3o3))
           ,TestCase (assertEqual "Translated sphere"
                     (makeVector 0 0.70711 (-0.70711))
                     (sphereNormalAt s1 $ makePoint 0 1.70711 (-0.70711)))
           ,TestCase (assertEqual "Transformed sphere"
                     (makeVector 0 0.97014 (-0.24254))
                     (sphereNormalAt s2 $ makePoint 0 r2o2 (-r2o2)))
           ]
  where
    s = makeSphere 1
    r3o3 = (sqrt 3) / 3
    s1 = sphereTranslate s $ makeTranslation 0 1 0
    ro2 = makeRotZ $ pi/5
    sc2 = makeScale 1 0.5 1
    s2 = sphereTransform s sc2
    s3 = sphereTransform s2 ro2
    r2o2 = (sqrt 2) / 2

testSphereMaterial :: Test
testSphereMaterial =
  TestList [TestCase (assertEqual "Default material"
                     (defaultMaterial)
                     (material s))
           ,TestCase (assertEqual "Set material"
                     (m2)
                     (material s1))
           ]
  where
    s = makeSphere 1
    m1 = defaultMaterial
    m2 = materialAmbient m1 1
    s1 = sphereMaterial s m2


sphereTests = [testMakeSphere
              ,testSphereTransform
              ,testSphereNormalAt
              ,testSphereMaterial
              ]
