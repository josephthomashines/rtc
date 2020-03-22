module Main where

import Test.HUnit
import System.Exit

import TestPoint (pointTests)

tests :: Test
tests = TestList $ []
                 ++ pointTests

main :: IO Counts
main = do
  results <- runTestTT $ tests
  if (errors results + failures results == 0)
    then
      exitWith ExitSuccess
    else
      exitWith (ExitFailure 1)
