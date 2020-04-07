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
wallSize = 7
rayOrigin = makePoint 0 0 (-5)
canvasPixels = 200
canvasBound = canvasPixels - 1
pixelSize = wallSize / canvasPixels
half = wallSize / 2

data CastingRay = CastingRay {ray :: Ray
                             ,px :: Int
                             ,py :: Int
                             }

posFromXY :: Float -> Float -> Point
posFromXY x y = makePoint worldX worldY wallZ
  where
    worldX = (-half) + (pixelSize * x)
    worldY = (half) - (pixelSize * y)

castingRayFromXY :: (Float, Float) -> CastingRay
castingRayFromXY (x,y) =
  CastingRay ray ix iy
  where
    ix = round x
    iy = round y
    ray =
      makeRay rayOrigin (vectorBetweenPoints ix iy $ posFromXY x y)

-- Determine if a specific ray casts a pixel onto the canvas
castRay :: CastingRay -> Sphere -> Canvas -> Canvas
castRay cr s ca =
  case h of
    Just h ->
      writePixel px1 py1 (makeColor 1 0.1 1) ca
    Nothing -> ca
  where
    r = ray cr
    px1 = px cr
    py1 = py cr
    h = hit $ raySphereIntersect r s
    or = origin r

-- Draw a vector from o to (x,y,wallZ)
vectorBetweenPoints :: Int -> Int -> Point -> Point
vectorBetweenPoints x y p =
  normalizePoint $ subPoints p rayOrigin

demoRay :: String -> IO ()
demoRay fs = do
  toPPM fs canvas2
  putStrLn $ "File saved to " ++ fs
  where
    sphere1 = makeSphere 1
    sphere2 = sphereTransform sphere1 (makeScale 1 1 1)

    iCanvasPixels = round canvasPixels
    canvas1 = makeCanvas iCanvasPixels iCanvasPixels

    pixels = [(x,y) | x<-[0..(canvasBound-1)],y<-[0..(canvasBound-1)]]
    rays = map castingRayFromXY pixels

    canvas2 = foldl (\ca cr -> castRay cr sphere2 ca) canvas1 rays
