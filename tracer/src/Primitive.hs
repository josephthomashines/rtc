module Primitive where


-- Types of Primitives
point = 1.0
vector = 0.0
err = 2.0

-- Basic tuple based data type
data Primitive = Primitive {x :: Float
                           ,y :: Float
                           ,z :: Float
                           ,w :: Float
                           }
  deriving (Show)

-- Rough float equal
floatEqual :: Float -> Float -> Bool
floatEqual a b = (abs $ a - b) <= 1E-7

instance Eq Primitive where
  a == b =
    (floatEqual (x a) (x b)) &&
    (floatEqual (y a) (y b)) &&
    (floatEqual (z a) (z b)) &&
    (floatEqual (w a) (w b))

-- Take x,y,z and return Point
makePoint :: Float -> Float -> Float -> Primitive
makePoint x y z = Primitive x y z point

-- Take x,y,z and return Vector
makeVector :: Float -> Float -> Float -> Primitive
makeVector x y z = Primitive x y z vector

-- Return a primitive with the error value
makeErr :: Primitive
makeErr = Primitive 0 0 0 err

-- Figure out the type of a Primitive
isPoint :: Primitive -> Bool
isPoint (Primitive _ _ _ w)
  | w == point  = True
  | otherwise   = False
isVector :: Primitive -> Bool
isVector (Primitive _ _ _ w)
  | w == vector = True
  | otherwise   = False
isErr :: Primitive -> Bool
isErr (Primitive _ _ _ w)
  | w == err  = True
  | otherwise = False
isValid :: Primitive -> Bool
isValid = not . isErr

-- Addition of Primitives, not allowed to add two points
addP :: Primitive -> Primitive -> Primitive
(Primitive ax ay az aw) `addP` (Primitive bx by bz bw)
  | aw+bw < 2    = (Primitive (ax+bx) (ay+by) (az+bz) (aw+bw))
  | otherwise     = makeErr

-- Subtraction of Primitives, not allowed to do vector - point
subPrimitives :: Primitive -> Primitive -> Primitive
subPrimitives (Primitive ax ay az aw) (Primitive bx by bz bw)
  | aw >= bw      = (Primitive (ax-bx) (ay-by) (az-bz) (aw-bw))
  | otherwise     = makeErr

-- Scale a primitive
multPrimitive :: Float -> Primitive -> Primitive
multPrimitive s (Primitive x y z w) =
  (Primitive (s*x) (s*y) (s*z) w)

dividePrimitive :: Float -> Primitive -> Primitive
dividePrimitive s p = multPrimitive (1.0/s) p

negatePrimitive :: Primitive -> Primitive
negatePrimitive p = multPrimitive (-1) p

-- Using Pythagorean's Theorem, get magnitude
magnitudePrimitive :: Primitive -> Float
magnitudePrimitive (Primitive x y z _) =
  sqrt $ x**2 + y**2 + z**2

-- Reduce the primitive to unit magnitude
normalizePrimitive :: Primitive -> Primitive
normalizePrimitive p =
  dividePrimitive m p
  where
    m = magnitudePrimitive p

-- Calculate the dot product
dotPrimitive :: Primitive -> Primitive -> Float
dotPrimitive (Primitive ax ay az _) (Primitive bx by bz _) =
  (ax*bx) + (ay*by) + (az*bz)

crossPrimitive :: Primitive -> Primitive -> Primitive
crossPrimitive (Primitive ax ay az _) (Primitive bx by bz _) =
  makeVector x y z
  where
    x = (ay*bz) - (az*by)
    y = (az*bx) - (ax*bz)
    z = (ax*by) - (ay*bx)
