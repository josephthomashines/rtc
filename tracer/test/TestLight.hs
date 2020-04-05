module TestLight where

import Color
import Light
import Point

import Test.HUnit

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


lightTests = [testPointLight
             ]
