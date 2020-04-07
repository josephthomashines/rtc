module Sphere where

import Material
import Matrix
import Point
import Transform

data Sphere = Sphere {sphereId :: Int
                     ,translate :: Transform
                     ,transform :: Transform
                     ,material :: Material
                     }
  deriving (Eq,Show)

defaultTransform :: Transform
defaultTransform = makeIdentity 4

-- TODO: Generic object + more data
makeSphere :: Int -> Sphere
makeSphere id = Sphere
                  id
                  defaultTransform
                  defaultTransform
                  defaultMaterial

-- Apply translation to sphere
sphereTranslate :: Sphere -> Transform -> Sphere
sphereTranslate s t = Sphere id t1 t2 m
  where
    id = sphereId s
    t1 = matrixMult t (translate s)
    t2 = transform s
    m = material s

-- Apply transformation to sphere
sphereTransform :: Sphere -> Transform -> Sphere
sphereTransform s t = Sphere id t1 t2 m
  where
    id = sphereId s
    t1 = translate s
    t2 = matrixMult t (transform s)
    m = material s

-- Get the normal vector at a point on the sphere
sphereNormalAt :: Sphere -> Point -> Point
sphereNormalAt s p =
  normalizePoint $
    Point (x worldNormal) (y worldNormal) (z worldNormal) 0
  where
    worldPoint = matrixFromPoint p
    sphereTrans = matrixMult (translate s) (transform s)
    objectPoint = pointFromMatrix $
      matrixMult (matrixInverse sphereTrans) (worldPoint)
    objectNormal = matrixFromPoint $ subPoints objectPoint $ makePoint 0 0 0
    worldNormal =
      pointFromMatrix $ matrixMult (matrixTranspose $ matrixInverse sphereTrans) (objectNormal)

-- Set sphere material
sphereMaterial :: Sphere -> Material -> Sphere
sphereMaterial s m = Sphere id t1 t2 m
  where
    id = sphereId s
    t1 = translate s
    t2 = transform s

