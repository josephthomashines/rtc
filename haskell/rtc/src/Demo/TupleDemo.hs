{-# LANGUAGE NamedFieldPuns #-}
module Demo.TupleDemo where

import Tuple

data Env = Env { grv :: Tuple
               , wnd :: Tuple
               }

data Prj = Prj { pos :: Tuple
               , vel :: Tuple
               }

tick :: Env -> Prj -> Prj
tick (Env { grv, wnd }) (Prj { pos, vel }) =
  Prj { pos = npos, vel = nvel }
  where
    npos = pos + vel
    nvel = vel + grv + wnd

sim :: Env -> Prj -> IO ()
sim e p@(Prj { pos }) = do
  if (tupleY pos) < 0
     then do
       putStrLn $ show $ (Tuple (tupleX pos) 0 (tupleZ pos) (tupleW pos))
       putStrLn ""
     else do
       putStrLn $ show pos
       sim e (tick e p)

demoTuple :: IO ()
demoTuple = sim e p
  where
    p = Prj { pos = (point 0 1 0), vel = (normalize $ vector 1 1 0) }
    e = Env { grv = (vector 0 (-0.1) 0), wnd = (vector (-0.01) 0 0) }

