module TestCanvas where

import Test.HUnit
import Canvas
import Color

testMakeCanvas :: Test
testMakeCanvas =
  TestList [TestCase (assertEqual "Width"
                     (10)
                     (width c)
                     )
           ,TestCase (assertEqual "Height"
                     (20)
                     (height c)
                     )
           ,TestCase (assertEqual "Pixels"
                     (10*20)
                     (numBlack)
                     )
           ]
  where
    c = makeCanvas 10 20
    numBlack = length
             $ filter (\c -> c == makeColor 0 0 0)
             $ concat
             $ pixels c

testWritePixel :: Test
testWritePixel =
  TestList [TestCase (assertEqual "Write Pixel"
                     (red)
                     (pixelAt 2 3 nc)
                     )
           ]
  where
    c = makeCanvas 10 20
    red = makeColor 1 0 0
    nc = writePixel 2 3 red c

testToPPMString :: Test
testToPPMString =
  TestList [TestCase (assertEqual "Header"
                     ("P3\n5 3\n255\n")
                     (unlines $ take 3 $ lines $ toPPMString c)
                     )
           ,TestCase (assertEqual "Body"
                     ("255 0 0 0 0 0 0 0 0 0 0 0 0 0 0\n"
                    ++"0 0 0 0 0 0 0 128 0 0 0 0 0 0 0\n"
                    ++"0 0 0 0 0 0 0 0 0 0 0 0 0 0 255\n")
                     (unlines $ drop 3 $ lines $ toPPMString nc3)
                     )
           ,TestCase (assertEqual "Wrapping body"
                     ("255 204 153 255 204 153 255 204 153 255 204 153 255 "
                    ++"204 153 255 204\n153 255 204 153 255 204 153 255 204"
                    ++" 153 255 204 153\n255 204 153 255 204 153 255 204 153"
                    ++" 255 204 153 255 204 153 255 204\n153 255 204 153 255"
                    ++" 204 153 255 204 153 255 204 153\n")
                     (unlines $ drop 3 $ lines $ toPPMString nca)
                     )
           ]
  where
    c = makeCanvas 5 3
    c1 = makeColor 1.5 0 0
    c2 = makeColor 0 0.5 0
    c3 = makeColor (-0.5) 0 1
    nc = writePixel 0 0 c1 c
    nc2 = writePixel 2 1 c2 nc
    nc3 = writePixel 4 2 c3 nc2
    ca = makeCanvas 10 2
    c4 = makeColor 1 0.8 0.6
    nca = writeAllPixels c4 ca


canvasTest :: [Test]
canvasTest = [testMakeCanvas
             ,testWritePixel
             ,testToPPMString
             ]
