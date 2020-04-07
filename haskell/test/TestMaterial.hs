module TestMaterial where

import Color
import Material

import Test.HUnit

testDefaultMaterial :: Test
testDefaultMaterial =
  TestList [TestCase (assertEqual "Color"
                     (makeColor 1 1 1)
                     (color m))
           ,TestCase (assertEqual "Ambient"
                     (0.1)
                     (ambient m))
           ,TestCase (assertEqual "Diffuse"
                     (0.9)
                     (diffuse m))
           ,TestCase (assertEqual "Specular"
                     (0.9)
                     (specular m))
           ,TestCase (assertEqual "Shininess"
                     (200.0)
                     (shininess m))
           ]
  where
    m = defaultMaterial


materialTests = [testDefaultMaterial
                ]
