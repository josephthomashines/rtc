module Primitive where

-- Basic tuple based data type
data Primitive = Primitive Float Float Float Float
  deriving (Show, Eq)

-- Take x,y,z and return Point
makePoint :: Float -> Float -> Float -> Primitive
makePoint x y z = Primitive x y z 1.0

-- Take x,y,z and return Vector
makeVector :: Float -> Float -> Float -> Primitive
makeVector x y z = Primitive x y z 0.0

-- Accessors
getX :: Primitive -> Float
getX (Primitive x _ _ _) = x
getY :: Primitive -> Float
getY (Primitive _ y _ _) = y
getZ :: Primitive -> Float
getZ (Primitive _ _ z _) = z

-- Figure out the type of a Primitive
isPoint :: Primitive -> Bool
isPoint (Primitive _ _ _ w)
  | w == 1.0    = True
  | otherwise   = False
isVector :: Primitive -> Bool
isVector = not . isPoint

-- Addition of Primitives, not allowed to add two points
addPrimitives :: Primitive -> Primitive -> Primitive
addPrimitives (Primitive ax ay az aw) (Primitive bx by bz bw)
  | aw+bw /= 2    = (Primitive (ax+bx) (ay+by) (az+bz) (aw+bw))
  | otherwise     = (Primitive 0 0 0 0)

-- Subtraction of Primitives, not allowed to do vector - point
subPrimitives :: Primitive -> Primitive -> Primitive
subPrimitives (Primitive ax ay az aw) (Primitive bx by bz bw)
  | aw >= bw      = (Primitive (ax-bx) (ay-by) (az-bz) (aw-bw))
  | otherwise     = (Primitive 0 0 0 0)

multPrimitive :: Float -> Primitive -> Primitive
multPrimitive s (Primitive x y z w) =
  (Primitive (s*x) (s*y) (s*y) w)

dividePrimitve :: Float -> Primitive -> Primitive
dividePrimitve s p = multPrimitive (1/s) p

negatePrimitive :: Primitive -> Primitive
negatePrimitive p = multPrimitive (-1) p
