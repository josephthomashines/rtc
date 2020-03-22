module TestCanvas where

import Test.HUnit
import Canvas
import Color

testMakeCanvas :: Test
testMakeCanvas =
  TestList [TestCase (assertEqual "Width"
                     (width c) (10))
           ,TestCase (assertEqual "Height"
                     (height c) (20))
           ,TestCase (assertEqual "Pixels"
                     (numBlack) (10*20))
           ]
  where
    c = makeCanvas 10 20
    numBlack = length
             $ filter (\c -> c == Color 0 0 0)
             $ concat
             $ pixels c

testWritePixel :: Test
testWritePixel =
  TestList [TestCase (assertEqual "Write Pixel"
                     (pixelAt 2 3 nc) (red))
           ]
  where
    c = makeCanvas 10 20
    red = Color 1 0 0
    nc = writePixel 2 3 red c

canvasTest :: [Test]
canvasTest = [testMakeCanvas
             ,testWritePixel
             ]
