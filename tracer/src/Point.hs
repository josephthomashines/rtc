module Point where

import Util (floatEqual)

-- Types of Points
point = 1.0
vector = 0.0

-- Basic tuple based data type
data Point = Point {x :: Float
                   ,y :: Float
                   ,z :: Float
                   ,w :: Float
                   }
  deriving (Show)

instance Eq Point where
  a == b = (floatEqual (x a) (x b))
        && (floatEqual (y a) (y b))
        && (floatEqual (z a) (z b))
        && (floatEqual (w a) (w b))

-- Take x,y,z and return Point
makePoint :: Float -> Float -> Float -> Point
makePoint x y z = Point x y z point

-- Take x,y,z and return Vector
makeVector :: Float -> Float -> Float -> Point
makeVector x y z = Point x y z vector

-- Figure out the type of a Point
isPoint :: Point -> Bool
isPoint (Point _ _ _ w)
  | w == point  = True
  | otherwise   = False
isVector :: Point -> Bool
isVector (Point _ _ _ w)
  | w == vector = True
  | otherwise   = False
isErr :: Point -> Bool
isErr (Point _ _ _ w)
  | w /= point && w /= vector      = True
  | otherwise                      = False
isValid :: Point -> Bool
isValid = not . isErr

-- Addition of Points, not allowed to add two points
addPoints :: Point -> Point -> Point
addPoints (Point ax ay az aw) (Point bx by bz bw) =
  (Point (ax+bx) (ay+by) (az+bz) (aw+bw))

-- Subtraction of Points, not allowed to do vector - point
subPoints :: Point -> Point -> Point
subPoints (Point ax ay az aw) (Point bx by bz bw) =
  (Point (ax-bx) (ay-by) (az-bz) (aw-bw))

-- Scale a point
scalePoint :: Float -> Point -> Point
scalePoint s (Point x y z w) =
  (Point (s*x) (s*y) (s*z) w)

-- Divide point
divPoint :: Float -> Point -> Point
divPoint s p = scalePoint (1.0/s) p

-- Negate point
negPoint :: Point -> Point
negPoint p = scalePoint (-1) p

-- Using Pythagorean's Theorem, get magnitude
magnitudePoint :: Point -> Float
magnitudePoint (Point x y z _) =
  sqrt $ x**2 + y**2 + z**2

-- Reduce the point to unit magnitude
normalizePoint :: Point -> Point
normalizePoint p =
  divPoint m p
  where
    m = magnitudePoint p

-- Dot product
dotPoints :: Point -> Point -> Float
dotPoints (Point ax ay az _) (Point bx by bz _) =
  (ax*bx) + (ay*by) + (az*bz)

-- Cross product
crossPoints :: Point -> Point -> Point
crossPoints (Point ax ay az _) (Point bx by bz _) =
  makeVector x y z
  where
    x = (ay*bz) - (az*by)
    y = (az*bx) - (ax*bz)
    z = (ax*by) - (ay*bx)

--
-- DEMO FUNCTIONS
--

data Projectile = Projectile {position :: Point
                             ,velocity :: Point
                             }
data Environment = Environment {gravity :: Point
                               ,wind :: Point
                               }

tick :: Environment -> Projectile -> Projectile
tick e p = Projectile np nv
  where
    np = addPoints (position p) (velocity p)
    nv = addPoints (velocity p) $ addPoints (gravity e) (wind e)

launchCore :: Environment -> Projectile -> Int -> String
launchCore e p c
  | currY <= 0 = "Landed at: "
              ++ (show $ position p)
              ++ "\n  after "
              ++ (show c)
              ++ " ticks."
  | otherwise  = "Position: "
              ++ (show $ position p)
              ++ "\n"
              ++ (launchCore e (tick e p) (c+1))
  where
    currY = y $ position p

launch :: Environment -> Projectile -> IO ()
launch e p = putStrLn $ launchCore e p 0

demoEnv = Environment (makeVector 0 (-9.8) 0) (makeVector 0 0 0)
demoProj = Projectile (makePoint 100 100 100) (makeVector 100 200 (-5))

demoPoint :: IO()
demoPoint = launch demoEnv demoProj
