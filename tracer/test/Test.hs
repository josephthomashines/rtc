module Main where

import Test.HUnit
import System.Exit

import TestCanvas (canvasTest)
import TestColor (colorTests)
import TestMatrix (matrixTests)
import TestPoint (pointTests)
import TestUtil (utilTests)

tests :: Test
tests = TestList $ []
                 ++ canvasTest
                 ++ colorTests
                 ++ matrixTests
                 ++ pointTests
                 ++ utilTests

main :: IO Counts
main = do
  results <- runTestTT $ tests
  if (errors results + failures results == 0)
    then
      exitWith ExitSuccess
    else
      exitWith (ExitFailure 1)
