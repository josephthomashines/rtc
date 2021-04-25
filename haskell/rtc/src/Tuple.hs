module Tuple (module Tuple, module Size) where

import Size
import SquareRoot

-- Tuple Type, constructors, and properties
data Tuple = Tuple Rational Rational Rational Rational
  deriving (Eq)

point :: Rational -> Rational -> Rational -> Tuple
point x y z = Tuple x y z 1.0

vector :: Rational -> Rational -> Rational -> Tuple
vector x y z = Tuple x y z 0.0

tupleX :: Tuple -> Rational
tupleX (Tuple x _ _ _) = x

tupleY :: Tuple -> Rational
tupleY (Tuple _ y _ _) = y

tupleZ :: Tuple -> Rational
tupleZ (Tuple _ _ z _) = z

tupleW :: Tuple -> Rational
tupleW (Tuple _ _ _ w) = w

isPoint :: Tuple -> Bool
isPoint (Tuple _ _ _ w) = w == 1.0

isVector :: Tuple -> Bool
isVector (Tuple _ _ _ w) = w == 0.0

-- Operators
instance Show Tuple where
  show (Tuple x y z w) = "[ "
                      ++ (show $ fromRational x) ++ ", "
                      ++ (show $ fromRational y) ++ ", "
                      ++ (show $ fromRational z) ++ ", "
                      ++ (show $ fromRational w) ++ " ]"

instance Num Tuple where
  (Tuple x y z w) + (Tuple i j k l) = Tuple (x+i) (y+j) (z+k) (w+l)
  (Tuple x y z w) * (Tuple i j k l) = Tuple (x*i) (y*j) (z*k) (w*l)
  (Tuple x y z w) - (Tuple i j k l) = Tuple (x-i) (y-j) (z-k) (w-l)
  abs (Tuple x y z w) = Tuple (abs x) (abs y) (abs z) (abs w)
  signum (Tuple x y z w) = Tuple (signum x) (signum y) (signum z) (signum w)
  fromInteger i = Tuple (fromInteger i) (fromInteger i) (fromInteger i) (fromInteger i)

instance Fractional Tuple where
  (Tuple x y z w) / (Tuple i j k l) = Tuple (x/i) (y/j) (z/k) (w/l)
  fromRational i = Tuple (fromRational i) (fromRational i) (fromRational i) (fromRational i)

instance Size Tuple where
  magnitude (Tuple x y z w) = rSqrt $ (x*x) + (y*y) + (z*z) + (w*w)

dot :: Tuple -> Tuple -> Rational
dot (Tuple x y z w) (Tuple i j k l) = (x*i) + (y*j) + (z*k) + (w*l)

cross :: Tuple -> Tuple -> Tuple
cross (Tuple x y z w) (Tuple i j k l) = vector nx ny nz
  where
    nx = (y*k) - (z*j)
    ny = (z*i) - (x*k)
    nz = (x*j) - (y*i)
