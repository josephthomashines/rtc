module Canvas where

import Color

data Canvas = Canvas {width :: Int
                     ,height :: Int
                     ,pixels :: [[Color]]
                     }

-- Provide prettier printing for debugging
instance Show Canvas where
  show c = "width: " ++ (show $ width c) ++ "\n"
    ++"height: " ++ (show $ height c) ++ "\n"
    ++"pixels: \n" ++ (pxs) ++ "\n"
    where
      pxs = unlines $ map (\r -> "  " ++ (show r)) (pixels c)

-- Initialize canvas with width + height to black
makeCanvas :: Int -> Int -> Canvas
makeCanvas w h = Canvas w h pixels
  where
    row = map (\_ -> Color 0 0 0) [1..w]
    pixels = map (\_ -> row) [1..h]

-- Get pixel at x,y
pixelAt :: Int -> Int -> Canvas -> Color
pixelAt x y c = (pixels c) !! y !! x

-- Return a canvas with the color of the provided pixel
-- set to the input color
writePixel :: Int -> Int -> Color -> Canvas -> Canvas
writePixel x y co ca = Canvas w h newPxs
  where
    w = width ca
    h = height ca
    pxs = pixels ca
    row = pxs !! y
    rowSplit = splitAt x row
    fr = fst rowSplit
    sr = tail $ snd rowSplit
    newRow = fr++[co]++sr
    pxsSplit = splitAt y pxs
    fp = fst pxsSplit
    sp = tail $ snd pxsSplit
    newPxs = fp++[newRow]++sp



