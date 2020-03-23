module TestColor where

import Test.HUnit
import Color

testAccess :: Test
testAccess =
  TestList [TestCase (assertEqual "Get r"
                     (-0.5)
                     (r c)
                     )
           ,TestCase (assertEqual "Get g"
                     (0.4)
                     (g c)
                     )
           ,TestCase (assertEqual "Get b"
                     (1.7)
                     (b c)
                     )
           ]
  where
    c = makeColor (-0.5) 0.4 1.7

testAddColors :: Test
testAddColors =
  TestList [TestCase (assertEqual "Addition"
                     (makeColor 1.6 0.7 1.0)
                     (addColors c1 c2)
                     )
           ]
  where
    c1 = makeColor 0.9 0.6 0.75
    c2 = makeColor 0.7 0.1 0.25

testSubColors :: Test
testSubColors =
  TestList [TestCase (assertEqual "Subtraction"
                     (makeColor 0.2 0.5 0.5)
                     (subColors c1 c2)
                     )
           ]
  where
    c1 = makeColor 0.9 0.6 0.75
    c2 = makeColor 0.7 0.1 0.25

testMultColors :: Test
testMultColors =
  TestList [TestCase (assertEqual "Multiply colors"
                     (makeColor 0.9 0.2 0.04)
                     (multColors c1 c2)
                     )
           ]
  where
    c1 = makeColor 1 0.2 0.4
    c2 = makeColor 0.9 1 0.1

testScaleColor :: Test
testScaleColor =
  TestList [TestCase (assertEqual "Scale color"
                     (makeColor 0.4 0.6 0.8)
                     (scaleColor 2 c)
                     )
           ]
  where
    c = makeColor 0.2 0.3 0.4

colorTests :: [Test]
colorTests = [testAccess
             ,testAddColors
             ,testSubColors
             ,testMultColors
             ]
