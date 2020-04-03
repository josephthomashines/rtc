module DemoRay where

import Canvas
import Color
import Matrix
import Point
import Ray
import Sphere
import Transform

import Data.Maybe

wallZ = 10
rayZ = -5
wc = 250

data CastingRay = CastingRay {ray :: Ray
                             ,px :: Int
                             ,py :: Int
                             }

-- Determine if a specific ray casts a pixel onto the canvas
castRay :: CastingRay -> Sphere -> Canvas -> Canvas
castRay cr s ca
  | isNothing h  = ca
  | otherwise    = red
  where
    r = ray cr
    px1 = px cr
    py1 = py cr
    h = hit $ raySphereIntersect r s
    or = origin r
    red = writePixel px1 py1 (makeColor 1 0 0) ca

-- Draw a vector from o to (x,y,wallZ)
vectorBetweenPoints :: Int -> Int -> Point -> Point
vectorBetweenPoints x y o =
  normalizePoint $ subPoints (makePoint ix iy wallZ) o
  where
    ix = fromIntegral x
    iy = fromIntegral y

demoRay :: String -> IO ()
demoRay fs = do
  toPPM fs ca
  putStrLn $ "File saved to " ++ fs
  where
    c = fromIntegral $ (wc `div` 2) - 1
    os = makeSphere 1
    os1 = sphereTransform os (makeScale 1 1 1)
    s = sphereTranslate os1 (makeTranslation c c 0)
    ori = makePoint c c (-1.0125)
    oc = makeCanvas wc wc
    rs = [(CastingRay (makeRay ori (vectorBetweenPoints x y ori)) x y)
          | x<-[0..(wc-1)],y<-[0..(wc-1)]]
    ca = foldl (\ca cr -> castRay cr s ca) oc rs
