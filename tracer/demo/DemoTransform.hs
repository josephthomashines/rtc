module DemoTransform where

import Canvas
import Color
import Matrix
import Point
import Transform

-- Given r in radians and a canvas, return a canvas where
-- a point is drawn on it at that point on the clock
clockPoint :: Float -> Canvas -> Canvas
clockPoint r ca =
  writePixel px py col ca
  where
    w = fromIntegral $ width ca
    h = fromIntegral $ height ca
    a = makeRotZ r
    s = 30
    b = makeScale s s s
    c = makeTranslation (w/2) (h/2) 0
    t = matrixMult c $ matrixMult b a
    p = makePointMatrix 0 1 0
    np = pointFromMatrix $ matrixMult t p
    px = round $ x np
    py = round $ (h-1) - (y np)
    col = makeColor 0.5 0.5 0


demoTransform :: String -> IO ()
demoTransform fs = do
  toPPM fs ca
  putStrLn $ "File saved to " ++ fs
  where
    n = 12
    rs = map (\x -> 2*pi*(x/n)) [1..n]
    ca = foldl (\ca r -> clockPoint r ca) (makeCanvas 100 100) rs


