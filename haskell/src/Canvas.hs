module Canvas where

import Color

data Canvas = Canvas {width :: !Int
                     ,height :: !Int
                     ,pixels :: ![[Color]]
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
    row = map (\_ -> makeColor 0 0 0) [1..w]
    pixels = map (\_ -> row) [1..h]

-- Get pixel at x,y
pixelAt :: Int -> Int -> Canvas -> Color
pixelAt x y c@(Canvas !w !h !p) = p !! y !! x

-- Return a canvas with the color of the provided pixel
-- set to the input color
writePixel :: Int -> Int -> Color -> Canvas -> Canvas
writePixel x y co ca@(Canvas !w !h !pxs) = Canvas w h newPxs
  where
    !row = pxs !! y
    !rowSplit = splitAt x row
    !fr = fst rowSplit
    !sr = tail $ snd rowSplit
    !newRow = fr++[co]++sr
    !pxsSplit = splitAt y pxs
    !fp = fst pxsSplit
    !sp = tail $ snd pxsSplit
    !newPxs = fp++[newRow]++sp

writeAllPixels :: Color -> Canvas -> Canvas
writeAllPixels co ca = Canvas w h npxs
  where
    w = width ca
    h = height ca
    pxs = pixels ca
    npxs = map (map (\_ -> co)) pxs

-- Wraps lines when the exceed a certain length
-- Thanks u/arnar on r/haskell!
wrapLine' :: Int -> String -> [String]
wrapLine' maxLen line = map unwords $ gobble 0 [] $ words line
    where
      gobble :: Int -> [String] -> [String] -> [[String]]
      gobble k acc [] = [reverse acc]
      gobble k acc ws@(w:rest)
          | l >= maxLen     = reverse acc : [w] : gobble 0 [] rest
          | k + l >= maxLen = reverse acc       : gobble 0 [] ws
          | otherwise       = gobble (k + l + 1) (w : acc) rest
          where l = length w

-- Convert the canvas to PPM format
toPPMString :: Canvas -> String
toPPMString c = header ++ body
  where
    version = "P3"
    dimensions = (show $ width c) ++ " " ++ (show $ height c)
    maxColor = "255"
    header = unlines $ [version,dimensions,maxColor]
    clamp i
      | i<0       = 0
      | i>255     = 255
      | otherwise = i
    convertColor co = nr ++ " " ++ ng ++ " " ++ nb ++ " "
      where
        nc = scaleColor 255 co
        nr = show . clamp . round $ r nc
        ng = show . clamp . round $ g nc
        nb = show . clamp . round $ b nc
    pxs = pixels c
    body = concat $ map (unlines . wrapLine' 70 . concat . map convertColor) pxs

-- Write the canvas to PPM file on disk
toPPM :: String -> Canvas -> IO ()
toPPM fs c = writeFile fs (toPPMString c)

