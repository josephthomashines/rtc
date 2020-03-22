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
  | w /= point && w /= vector      = True
  | otherwise                      = False
isValid :: Primitive -> Bool
isValid = not . isErr

-- Addition of Primitives, not allowed to add two points
addP :: Primitive -> Primitive -> Primitive
addP (Primitive ax ay az aw) (Primitive bx by bz bw) =
  (Primitive (ax+bx) (ay+by) (az+bz) (aw+bw))

-- Subtraction of Primitives, not allowed to do vector - point
subP :: Primitive -> Primitive -> Primitive
subP (Primitive ax ay az aw) (Primitive bx by bz bw) =
  (Primitive (ax-bx) (ay-by) (az-bz) (aw-bw))

-- Scale a primitive
scaleP :: Float -> Primitive -> Primitive
scaleP s (Primitive x y z w) =
  (Primitive (s*x) (s*y) (s*z) w)

divP :: Float -> Primitive -> Primitive
divP s p = scaleP (1.0/s) p

negP :: Primitive -> Primitive
negP p = scaleP (-1) p

-- Using Pythagorean's Theorem, get magnitude
magnitudeP :: Primitive -> Float
magnitudeP (Primitive x y z _) =
  sqrt $ x**2 + y**2 + z**2

-- Reduce the primitive to unit magnitude
normalizeP :: Primitive -> Primitive
normalizeP p =
  divP m p
  where
    m = magnitudeP p

-- Calculate the dot product
dotP :: Primitive -> Primitive -> Float
dotP (Primitive ax ay az _) (Primitive bx by bz _) =
  (ax*bx) + (ay*by) + (az*bz)

crossP :: Primitive -> Primitive -> Primitive
crossP (Primitive ax ay az _) (Primitive bx by bz _) =
  makeVector x y z
  where
    x = (ay*bz) - (az*by)
    y = (az*bx) - (ax*bz)
    z = (ax*by) - (ay*bx)
