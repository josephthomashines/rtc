module Matrix where

import Data.List

import Point
import Util (floatEqual)

-- Matrix is a 2D list
type Matrix = [[Float]]

makeMatrix :: [[Float]] -> Matrix
makeMatrix f = f

-- Get a matrix from a point
matrixFromPoint :: Point -> Matrix
matrixFromPoint (Point x y z w) =
  [[x]
  ,[y]
  ,[z]
  ,[w]]

-- Get a point from a matrix
pointFromMatrix :: Matrix -> Point
pointFromMatrix m = Point nx ny nz nw
  where
    nx = getMatrixValue 0 0 m
    ny = getMatrixValue 1 0 m
    nz = getMatrixValue 2 0 m
    nw = getMatrixValue 3 0 m

-- Matrices use floats, need to use rough equality check
matrixEqual :: Matrix -> Matrix -> Bool
matrixEqual a b =
  aLength == bLength
    && aLength == (length
                   $ filter (\x -> x)
                   $ zipWith (\x y -> floatEqual x y) ca cb)
    where
      ca = concat a
      cb = concat b
      aLength = length $ ca
      bLength = length $ cb

-- Pretty format Matrix
showMatrix :: Matrix -> String
showMatrix m =
  unlines
  $ map (show) m

-- Prints the matrix
putMatrix :: Matrix -> IO ()
putMatrix = putStrLn . showMatrix

-- An infinitely large matrix with 1's on the diagonal
infiniteIdentity :: Matrix
infiniteIdentity =
  ((1.0 : repeat 0.0) : fmap (0.0:) infiniteIdentity)

-- Take a slice of the infinite matrix of input size
makeIdentity :: Int -> Matrix
makeIdentity i =
  (take i (fmap (take i) infiniteIdentity))

-- Get the value at x,y in a matrix
getMatrixValue :: Int -> Int -> Matrix -> Float
getMatrixValue y x m = m !! y !! x

-- Matrix multiplication, thanks to
-- https://rosettacode.org/wiki/Matrix_multiplication#Haskell
-- for the clean implementation
matrixMult :: Matrix -> Matrix -> Matrix
matrixMult a b = [[ sum $ zipWith (*) ar bc | bc <- (transpose b) ]
                    | ar <- a ]

