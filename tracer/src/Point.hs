module Point where


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

-- Rough float equal
floatEqual :: Float -> Float -> Bool
floatEqual a b = (abs $ a - b) <= 1E-7

instance Eq Point where
  a == b =
    (floatEqual (x a) (x b)) &&
    (floatEqual (y a) (y b)) &&
    (floatEqual (z a) (z b)) &&
    (floatEqual (w a) (w b))

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
addP :: Point -> Point -> Point
addP (Point ax ay az aw) (Point bx by bz bw) =
  (Point (ax+bx) (ay+by) (az+bz) (aw+bw))

-- Subtraction of Points, not allowed to do vector - point
subP :: Point -> Point -> Point
subP (Point ax ay az aw) (Point bx by bz bw) =
  (Point (ax-bx) (ay-by) (az-bz) (aw-bw))

-- Scale a primitive
scaleP :: Float -> Point -> Point
scaleP s (Point x y z w) =
  (Point (s*x) (s*y) (s*z) w)

divP :: Float -> Point -> Point
divP s p = scaleP (1.0/s) p

negP :: Point -> Point
negP p = scaleP (-1) p

-- Using Pythagorean's Theorem, get magnitude
magnitudeP :: Point -> Float
magnitudeP (Point x y z _) =
  sqrt $ x**2 + y**2 + z**2

-- Reduce the primitive to unit magnitude
normalizeP :: Point -> Point
normalizeP p =
  divP m p
  where
    m = magnitudeP p

-- Calculate the dot product
dotP :: Point -> Point -> Float
dotP (Point ax ay az _) (Point bx by bz _) =
  (ax*bx) + (ay*by) + (az*bz)

crossP :: Point -> Point -> Point
crossP (Point ax ay az _) (Point bx by bz _) =
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
    np = addP (position p) (velocity p)
    nv = addP (velocity p) $ addP (gravity e) (wind e)

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
demoProj = Projectile (makePoint 100 100 100) (makeVector 50 20 50)

