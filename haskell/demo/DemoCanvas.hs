module DemoCanvas where

import Canvas
import Color
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

launchCore :: Environment -> Projectile -> Canvas -> Canvas
launchCore e p c
  | currY <= 0 = writePixel iX h (makeColor 0 1 0) c
  | otherwise  = (launchCore e
                  (tick e p)
                  (writePixel
                    iX
                    (h-iY)
                    (makeColor 0.5 0.5 0)
                    c))
  where
    pos = position p
    h = (height c) - 1
    currY = y pos
    iY = round currY
    currX = x pos
    iX = round currX

launch :: Environment -> Projectile -> String -> IO ()
launch e p fs = toPPM fs $ launchCore e p (makeCanvas 900 550)

demoEnv = Environment (makeVector 0 (-0.1) 0) (makeVector (-0.01) 0 0)
demoProj = Projectile
             (makePoint 0 1 0)
             (scalePoint 11.25 $ normalizePoint $ makeVector 1 1.8 0)

demoCanvas :: String -> IO()
demoCanvas fs = do
  launch demoEnv demoProj fs
  putStrLn $ "File saved to " ++ fs
