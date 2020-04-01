module Ray where

import Point
import Sphere

import Data.List

-- A ray has an origin and a direction
data Ray = Ray {origin :: Point
               ,direction :: Point
               }

makeRay :: Point -> Point -> Ray
makeRay o d = Ray o d

-- Get the ray's position at "time" t
rayPosition :: Ray -> Float -> Point
rayPosition r t =
  addPoints (o) (scalePoint t d)
  where
    o = origin r
    d = direction r

-- Get where the ray intersects the sphere
raySphereIntersect :: Ray -> Sphere -> [Float]
raySphereIntersect r s
  | discrim < 0    = []
  | otherwise      = sort [t1,t2]
  where
    o = origin r
    d = direction r
    s2r = subPoints o (makePoint 0 0 0)
    a = dotPoints d d
    b = 2 * dotPoints d s2r
    c = (dotPoints s2r s2r) - 1
    discrim = (b^2) - 4*a*c
    ad = abs discrim
    t1 = (-b - (sqrt ad)) / (2*a)
    t2 = (-b + (sqrt ad)) / (2*a)

-- Type to track intersections
-- TODO: Replace sphere with generic object
data Intersection = Intersection {t :: Float
                                 ,object :: Sphere
                                 }

makeIntersection :: Float -> Sphere -> Intersection
makeIntersection t obj = Intersection t obj
