module Util where

-- Rough float equal
floatEqual :: Float -> Float -> Bool
floatEqual a b = (abs $ a - b) <= 1E-6
