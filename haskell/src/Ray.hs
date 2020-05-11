module Ray where

import Matrix
import Point
import Sphere
import Transform

import Util (floatEqual)

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
raySphereIntersect :: Ray -> Sphere -> Intersections
raySphereIntersect r@(Ray !o !d) s
  | discrim < 0    = []
  | otherwise      = rts
  where
    !tr1 = rayTranslate r (matrixInverse $ translate s)
    !tr = rayTransform tr1 (matrixInverse $ transform s)
    !s2r = subPoints o (makePoint 0 0 0)
    !a = dotPoints d d
    !b = 2 * dotPoints d s2r
    !c = (dotPoints s2r s2r) - 1
    !discrim = (b^2) - 4*a*c
    !ad = abs discrim
    !t1 = (-b - (sqrt ad)) / (2*a)
    !t2 = (-b + (sqrt ad)) / (2*a)
    !ts = sort [t1,t2]
    !rts = map (\t -> makeIntersection t s) ts

-- Type to track intersections
-- TODO: Replace sphere with generic object
data Intersection = Intersection {t :: Float
                                 ,object :: Sphere
                                 }
  deriving (Show)

instance Eq Intersection where
  a == b = (floatEqual (t a) (t b))
        && ((object a) == (object b))

makeIntersection :: Float -> Sphere -> Intersection
makeIntersection t obj = Intersection t obj

type Intersections = [Intersection]

-- Returns the smallest positive t-valued intersection,
-- or nothing if no valid hits
hit :: Intersections -> Maybe Intersection
hit is
  | length psis > 0    = Just $ head psis
  | otherwise          = Nothing
  where
    sis = sortOn t is
    psis = filter (\i -> (t i) >= 0) sis

-- Translate a ray
rayTranslate :: Ray -> Transform -> Ray
rayTranslate r t = makeRay ot (pointFromMatrix d)
  where
    o = matrixFromPoint $ origin r
    d = matrixFromPoint $ direction r
    ot = pointFromMatrix $ matrixMult t o
    dt = pointFromMatrix $ matrixMult t d

-- Transform a ray
rayTransform :: Ray -> Transform -> Ray
rayTransform r t = makeRay ot dt
  where
    o = matrixFromPoint $ origin r
    d = matrixFromPoint $ direction r
    ot = pointFromMatrix $ matrixMult t o
    dt = pointFromMatrix $ matrixMult t d
