module TestLight where

import Color
import Light
import Material
import Point

import Test.HUnit

r2o2 = (sqrt 2) / 2

testPointLight :: Test
testPointLight =
  TestList [TestCase (assertEqual "Sets intensity correctly"
                     (i)
                     (intensity pl))
           ,TestCase (assertEqual "Sets point correctly"
                     (p)
                     (position pl))
           ]
  where
    i = makeColor 1 1 1
    p = makePoint 0 0 0
    pl = makePointLight i p

testLighting :: Test
testLighting =
  TestList [TestCase (assertEqual "Eye directly between source and surface"
                     (makeColor 1.9 1.9 1.9)
                     (res1))
           ,TestCase (assertEqual "Eye offset at 45 deg"
                     (makeColor 1 1 1)
                     (res2))
           ,TestCase (assertEqual "Light offset at 45 deg"
                     (makeColor 0.7364 0.7364 0.7364 )
                     (res3))
           ,TestCase (assertEqual "Reflection"
                     (makeColor 1.6364 1.6364 1.6364 )
                     (res4))
           ,TestCase (assertEqual "Light behind surface"
                     (makeColor 0.1 0.1 0.1)
                     (res5))
           ]
  where
    m = defaultMaterial
    pos = makePoint 0 0 0

    eyeV1 = makeVector 0 0 (-1)
    normV1 = makeVector 0 0 (-1)
    light1 = makePointLight (makeColor 1 1 1) (makePoint 0 0 (-10))
    res1 = lighting m light1 pos eyeV1 normV1

    eyeV2 = makeVector 0 r2o2 (-r2o2)
    normV2 = makeVector 0 0 (-1)
    light2 = makePointLight (makeColor 1 1 1) (makePoint 0 0 (-10))
    res2 = lighting m light2 pos eyeV2 normV2

    eyeV3 = eyeV1
    normV3 = normV1
    light3 = makePointLight (makeColor 1 1 1) (makePoint 0 10 (-10))
    res3 = lighting m light3 pos eyeV3 normV3

    eyeV4 = makeVector 0 (-r2o2) (-r2o2)
    normV4 = normV3
    light4 = makePointLight (makeColor 1 1 1) (makePoint 0 10 (-10))
    res4 = lighting m light4 pos eyeV4 normV4

    eyeV5 = eyeV3
    normV5 = normV3
    light5 = makePointLight (makeColor 1 1 1) (makePoint 0 0 10)
    res5 = lighting m light5 pos eyeV5 normV5


lightTests = [testPointLight
             ,testLighting
             ]
