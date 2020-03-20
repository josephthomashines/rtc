module Main where

import Test.HUnit
import System.Exit

import TestPrimitive (primitiveTests)

tests :: Test
tests = TestList $ []
                 ++ primitiveTests

main :: IO Counts
main = do
  results <- runTestTT $ tests
  if (errors results + failures results == 0)
    then
      exitWith ExitSuccess
    else
      exitWith (ExitFailure 1)
