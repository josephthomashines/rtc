module DemoPoint where

import Point

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
