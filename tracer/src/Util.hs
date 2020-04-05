module Util where

-- Rough float equal
floatEqual :: Float -> Float -> Bool
floatEqual a b = (abs $ a - b) <= 1E-3

-- Remove the nth item from a list
removeN :: Int -> [a] -> [a]
-- removeN n l = (fst s) ++ (tail $ snd s)
--   where
--     s = splitAt n l

removeN n l = (take n l) ++ (drop (n+1) l)

-- Chunk a list into n chunks
chunkList :: Int -> [a] -> [[a]]
chunkList _ [] = []
chunkList n l = (take n l) : (chunkList n (drop n l))
