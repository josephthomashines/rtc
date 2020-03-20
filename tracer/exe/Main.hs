module Main where

import System.Environment
import Tracer

main = mapM_ (putStrLn . trace) =<< getArgs

