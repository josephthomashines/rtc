module DemoLight where

import Canvas
import Color
import Light
import Material
import Matrix
import Point
import Ray
import Sphere
import Transform

import Data.List
import Data.Maybe

wallZ = 10
wallSize = 7
rayOrigin = makePoint 0 0 (-5)
canvasPixels = 2000
canvasBound = canvasPixels - 1
pixelSize = wallSize / canvasPixels
half = wallSize / 2

data CastingRay = CastingRay {ray :: !Ray
                             ,px :: !Int
                             ,py :: !Int
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
castRay :: CastingRay -> Sphere -> PointLight -> Canvas -> Canvas
castRay cr@(CastingRay !r !px1 !py1) !s !pl ca =
  case h of
    Just h ->
      writePixel px1 py1 l ca
      where
        !hitT = t h
        !hitObject = object h
        !hitMaterial = material hitObject
        point = rayPosition r hitT
        normal = sphereNormalAt hitObject point
        eyeV = negPoint $ direction r
        !l = lighting hitMaterial pl point eyeV normal
    Nothing -> ca
  where
    h = hit $ raySphereIntersect r s
    or = origin r

-- Draw a vector from o to (x,y,wallZ)
vectorBetweenPoints :: Int -> Int -> Point -> Point
vectorBetweenPoints x y p =
  normalizePoint $ subPoints p rayOrigin

demoLight :: String -> IO ()
demoLight fs = do
  toPPM fs canvas2
  putStrLn $ "File saved to " ++ fs
  where
    sphereMaterial1 = defaultMaterial
    sphereMaterialColor = makeColor 1 0.2 1
    sphereMaterial2 = materialColor sphereMaterial1 sphereMaterialColor
    sphere1 = makeSphere 1
    sphere2 = sphereTransform sphere1 (makeScale 1 1 1)
    sphere3 = sphereMaterial sphere2 sphereMaterial2

    pointLight = makePointLight (makeColor 1 1 1) (makePoint (-10) 10 (-10))

    iCanvasPixels = round canvasPixels
    canvas1 = makeCanvas iCanvasPixels iCanvasPixels

    pixels = [(x,y) | x<-[0..(canvasBound-1)],y<-[0..(canvasBound-1)]]
    rays = map castingRayFromXY pixels

    canvas2 = foldl' (\ca cr -> castRay cr sphere3 pointLight ca) canvas1 rays
