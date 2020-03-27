module Util where

-- Rough float equal
floatEqual :: Float -> Float -> Bool
floatEqual a b = (abs $ a - b) <= 1E-6


-- Remove the nth item from a list
removeN :: Int -> [a] -> [a]
removeN n l = (fst s) ++ (tail $ snd s)
  where
    s = splitAt n l
