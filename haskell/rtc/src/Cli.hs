module Cli where

import System.Environment
import System.Exit

import Demo.TupleDemo

demos = [
        "tuple"
        ]

availableDemos = do
  putStrLn "Available demos:"
  putStrLn $ unlines $ map ("\t" ++) demos

runDemo "tuple" = demoTuple
runDemo d = do
  usage
  putStrLn $ "Unknown demo: " ++ d
  availableDemos
  exitFail

run = getArgs >>= parse >>= putStr

parse ["-h"] = do usage   >> exit
parse ["-v"] = version >> exit
parse ["-d"] = do
  usage
  availableDemos
  exitFail
parse ["-d", demo] = runDemo demo >> exit
--parse []     = getContents
--parse fs     = concat `fmap` mapM readFile fs
parse _ = usage >> exitFail

usage     = putStrLn "Usage: rtc [-vh] [-d DEMO]"
version   = putStrLn "rtc 0.1"
exit      = exitWith ExitSuccess
exitFail  = exitWith (ExitFailure 1)



