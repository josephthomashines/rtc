module Matrix where

import Data.List

import Point
import Util (floatEqual
            ,removeN
            ,chunkList)

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

-- Multiply all elements in a matrix by a value
scaleMatrix :: Float -> Matrix -> Matrix
scaleMatrix n m = map (map (* n)) m

-- Matrix multiplication, thanks to
-- https://rosettacode.org/wiki/Matrix_multiplication#Haskell
-- for the clean implementation
matrixMult :: Matrix -> Matrix -> Matrix
matrixMult a b = [[ sum $ zipWith (*) ar bc | bc <- (transpose b) ]
                    | ar <- a ]

-- Get the transpose of the matrix
matrixTranspose :: Matrix -> Matrix
matrixTranspose = transpose

-- Calculate the determinant of a matrix using the cofactor method
matrixDeterminant :: Matrix -> Float
matrixDeterminant m
  | l == 2     = (a*d) - (b*c)
  | otherwise  = sub
  where
    l = length m
    a = getMatrixValue 0 0 m
    b = getMatrixValue 0 1 m
    c = getMatrixValue 1 0 m
    d = getMatrixValue 1 1 m
    sub = sum $ map (\(a,b) -> b * (matrixCofactor 0 a m)) $ zip [0..(l-1)] (m !! 0)

-- Get a submatrix of size N-1 for an arbitrarily sized matrix
subMatrix :: Int -> Int -> Matrix -> Matrix
subMatrix row col m = removeN row $ map (removeN col) m

-- Get the minor at row,col
matrixMinor :: Int -> Int -> Matrix -> Float
matrixMinor row col m =
  matrixDeterminant $ subMatrix row col m

-- Compute the cofactor of the matrix
matrixCofactor :: Int -> Int -> Matrix -> Float
matrixCofactor row col m
  | odd         = (-1) * minor
  | otherwise   = minor
  where
    odd = (row+col) `mod` 2 /= 0
    minor = matrixMinor row col m

-- Tests to see if a matrix is invertible
isMatrixInvertible :: Matrix -> Bool
isMatrixInvertible m =
  matrixDeterminant m /= 0

-- Get the inverse of the matrix, if it has one
matrixInverse :: Matrix -> Matrix
matrixInverse m
  | isMatrixInvertible m    = scaleMatrix (1/det) $ matrixTranspose cofactors
  | otherwise               = error ("Matrix is not invertible\n"
                                 ++ showMatrix m)
  where
    det = matrixDeterminant m
    l = length m
    xy = chunkList l [(x,y) | x<-[0..(l-1)],y<-[0..(l-1)]]
    cofactors = map (map (\(x,y) -> matrixCofactor x y m)) xy

