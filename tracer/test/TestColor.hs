module TestColor where

import Test.HUnit
import Color

testAccess :: Test
testAccess =
  TestList [TestCase (assertEqual "Get r"
                     (r c) (-0.5))
           ,TestCase (assertEqual "Get g"
                     (g c) (0.4))
           ,TestCase (assertEqual "Get b"
                     (b c) (1.7))
           ]
  where
    c = Color (-0.5) 0.4 1.7

testAddColors :: Test
testAddColors =
  TestList [TestCase (assertEqual "Addition"
                     (addColors c1 c2) (Color 1.6 0.7 1.0))
           ]
  where
    c1 = Color 0.9 0.6 0.75
    c2 = Color 0.7 0.1 0.25

testSubColors :: Test
testSubColors =
  TestList [TestCase (assertEqual "Subtraction"
                     (subColors c1 c2) (Color 0.2 0.5 0.5))
           ]
  where
    c1 = Color 0.9 0.6 0.75
    c2 = Color 0.7 0.1 0.25

testMultColors :: Test
testMultColors =
  TestList [TestCase (assertEqual "Multiply colors"
                     (multColors c1 c2) (Color 0.9 0.2 0.04))
           ]
  where
    c1 = Color 1 0.2 0.4
    c2 = Color 0.9 1 0.1

testScaleColor :: Test
testScaleColor =
  TestList [TestCase (assertEqual "Scale color"
                     (scaleColor 2 c) (Color 0.4 0.6 0.8))
           ]
  where
    c = Color 0.2 0.3 0.4

colorTests :: [Test]
colorTests = [testAccess
             ,testAddColors
             ,testSubColors
             ,testMultColors
             ]
