module Sphere where

import Matrix
import Transform

data Sphere = Sphere {sphereId :: Int
                     ,translate :: Transform
                     ,transform :: Transform
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

-- Apply translation to sphere
sphereTranslate :: Sphere -> Transform -> Sphere
sphereTranslate s t = Sphere id t1 t2
  where
    id = sphereId s
    t1 = matrixMult t (translate s)
    t2 = transform s

-- Apply transformation to sphere
sphereTransform :: Sphere -> Transform -> Sphere
sphereTransform s t = Sphere id t1 t2
  where
    id = sphereId s
    t1 = translate s
    t2 = matrixMult t (transform s)

