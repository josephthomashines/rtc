module TupleSpec (spec) where

import SquareRoot
import Test.Hspec
import Tuple

spec :: Spec
spec = do
  describe "Tuple Properties and Constructors" $ do
    it "is a point if w = 1.0" $ do
      let a = Tuple 4.3 (-4.2) 3.1 1.0
      (tupleX a) `shouldBe` (4.3)
      (tupleY a) `shouldBe` (-4.2)
      (tupleZ a) `shouldBe` (3.1)
      (tupleW a) `shouldBe` (1.0)
      (isPoint a) `shouldBe` (True)
      (isVector a) `shouldBe` (False)
    it "is a vector if w = 0.0" $ do
      let a = Tuple 4.3 (-4.2) 3.1 0.0
      (tupleX a) `shouldBe` (4.3)
      (tupleY a) `shouldBe` (-4.2)
      (tupleZ a) `shouldBe` (3.1)
      (tupleW a) `shouldBe` (0.0)
      (isPoint a) `shouldBe` (False)
      (isVector a) `shouldBe` (True)
    it "provides a correct point constructor" $ do
      let p = point 4 (-4) 3
      (p) `shouldBe` (Tuple 4 (-4) 3 1.0)
    it "provides a correct vector constructor" $ do
      let p = vector 4 (-4) 3
      (p) `shouldBe` (Tuple 4 (-4) 3 0.0)
  describe "Tuple Operators" $ do
    it "adds two tuples" $ do
      let a1 = Tuple 3 (-2) 5 1
      let a2 = Tuple (-2) 3 1 0
      (a1 + a2) `shouldBe` (Tuple 1 1 6 1)
    it "subtracts two points" $ do
      let p1 = point 3 2 1
      let p2 = point 5 6 7
      (p1 - p2) `shouldBe` (vector (-2) (-4) (-6))
    it "subtracts a vector from a point" $ do
      let p = point 3 2 1
      let v = vector 5 6 7
      (p - v) `shouldBe` (point (-2) (-4) (-6))
    it "subtracts two vectors" $ do
      let v1 = vector 3 2 1
      let v2 = vector 5 6 7
      (v1 - v2) `shouldBe` (vector (-2) (-4) (-6))
    it "negates tuples" $ do
      let a = Tuple 1 (-2) 3 (-4)
      (negate a) `shouldBe` (Tuple (-1) 2 (-3) 4)
      (-a) `shouldBe` (Tuple (-1) 2 (-3) 4)
    it "scalar multiplies" $ do
      let a = Tuple 1 (-2) 3 (-4)
      (a * 3.5) `shouldBe` (Tuple 3.5 (-7) 10.5 (-14))
      (a * 0.5) `shouldBe` (Tuple 0.5 (-1) 1.5 (-2))
    it "scalar divides" $ do
      let a = Tuple 1 (-2) 3 (-4)
      (a / 2) `shouldBe` (Tuple 0.5 (-1) 1.5 (-2))
    it "calculates magnitude" $ do
      let v = vector 1 0 0
      (magnitude v) `shouldBe` (1)
      let v = vector 0 1 0
      (magnitude v) `shouldBe` (1)
      let v = vector 0 0 1
      (magnitude v) `shouldBe` (1)
      let v = vector 1 2 3
      (magnitude v) `shouldBe` (rSqrt 14)
      let v = vector (-1) (-2) (-3)
      (magnitude v) `shouldBe` (rSqrt 14)
    it "normalizes vector" $ do
      let v = vector 4 0 0
      (normalize v) `shouldBe` vector 1 0 0
      let v = vector 1 2 3
      (normalize v) `shouldBe` vector (1 / rSqrt 14) (2 / rSqrt 14) (3 / rSqrt 14)
      (magnitude $ normalize v) `shouldBe` 1
    it "computes the dot product" $ do
      let a = vector 1 2 3
      let b = vector 2 3 4
      (dot a b) `shouldBe` 20
    it "computes the cross product" $ do
      let a = vector 1 2 3
      let b = vector 2 3 4
      (cross a b) `shouldBe` (vector (-1) 2 (-1))
      (cross b a) `shouldBe` (vector 1 (-2) 1)


