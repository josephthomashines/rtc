{-# LANGUAGE TemplateHaskell #-}

module Main (
  main,
  ) where

import Test.QuickCheck
import PV

-------------------------------------------------------------------------------
  -- PV --

-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
return []
runTests = $quickCheckAll

main :: IO Bool
main =
  runTests


