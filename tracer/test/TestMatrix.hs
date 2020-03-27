module TestMatrix where

import Test.HUnit

import Matrix
import Point

testMakeMatrix :: Test
testMakeMatrix =
  TestList [TestCase (assertEqual "M1[0,0]"
                     (1)
                     (getMatrixValue 0 0 m1))
           ,TestCase (assertEqual "M1[0,3]"
                     (4)
                     (getMatrixValue 0 3 m1))
           ,TestCase (assertEqual "M1[1,0]"
                     (5.5)
                     (getMatrixValue 1 0 m1))
           ,TestCase (assertEqual "M1[1,2]"
                     (7.5)
                     (getMatrixValue 1 2 m1))
           ,TestCase (assertEqual "M1[2,2]"
                     (11)
                     (getMatrixValue 2 2 m1))
           ,TestCase (assertEqual "M1[3,0]"
                     (13.5)
                     (getMatrixValue 3 0 m1))
           ,TestCase (assertEqual "M1[3,2]"
                     (15.5)
                     (getMatrixValue 3 2 m1))
           ,TestCase (assertEqual "M2[0,0]"
                     (-3)
                     (getMatrixValue 0 0 m2))
           ,TestCase (assertEqual "M2[0,1]"
                     (5)
                     (getMatrixValue 0 1 m2))
           ,TestCase (assertEqual "M2[1,0]"
                     (1)
                     (getMatrixValue 1 0 m2))
           ,TestCase (assertEqual "M2[1,1]"
                     (-2)
                     (getMatrixValue 1 1 m2))
           ,TestCase (assertEqual "M3[0,0]"
                     (-3)
                     (getMatrixValue 0 0 m3))
           ,TestCase (assertEqual "M3[1,1]"
                     (-2)
                     (getMatrixValue 1 1 m3))
           ,TestCase (assertEqual "M3[2,2]"
                     (1)
                     (getMatrixValue 2 2 m3))
           ]
  where
    m1 = makeMatrix [[1,2,3,4]
                   ,[5.5,6.5,7.5,8.5]
                   ,[9,10,11,12]
                   ,[13.5,14.5,15.5,16.5]]
    m2 = makeMatrix [[(-3),5]
                    ,[1,(-2)]]
    m3 = makeMatrix [[(-3),5,0]
                    ,[1,(-2),(-7)]
                    ,[0,1,1]]

testMatrixEqual :: Test
testMatrixEqual =
  TestList [TestCase (assertEqual "Equal"
                     (True)
                     (matrixEqual a b))
           ,TestCase (assertEqual "Not Equal"
                     (False)
                     (matrixEqual a c))
           ]
  where
    a = makeMatrix [[1,2,3,4]
                   ,[5,6,7,8]
                   ,[9,8,7,6]
                   ,[5,4,3,2]]
    b = makeMatrix [[1,2,3,4]
                   ,[5,6,7,8]
                   ,[9,8,7,6]
                   ,[5,4,3,2]]
    c = reverse $ map reverse b

testMatrixMult :: Test
testMatrixMult =
  TestList [TestCase (assertEqual "AB"
                     (True)
                     (matrixEqual (matrixMult a b) ab))
           ,TestCase (assertEqual "Cd"
                     (True)
                     (matrixEqual (matrixMult c d) cd))
           ,TestCase (assertEqual "Identity"
                     (True)
                     (matrixEqual (matrixMult c i) c))
           ]
  where
    a = makeMatrix [[1,2,3,4]
                   ,[5,6,7,8]
                   ,[9,8,7,6]
                   ,[5,4,3,2]]
    b = makeMatrix [[(-2),1,2,3]
                   ,[3,2,1,(-1)]
                   ,[4,3,6,5]
                   ,[1,2,7,8]]
    ab = makeMatrix [[20,22,50,48]
                    ,[44,54,114,108]
                    ,[40,58,110,102]
                    ,[16,26,46,42]]
    c = makeMatrix [[1,2,3,4]
                   ,[2,4,4,2]
                   ,[8,6,4,1]
                   ,[0,0,0,1]]
    d = matrixFromPoint $ makePoint 1 2 3
    cd = matrixFromPoint $ makePoint 18 24 33
    i = makeIdentity 4

testMatrixTranspose :: Test
testMatrixTranspose =
  TestList [TestCase (assertEqual "Can transpose"
                     (True)
                     (matrixEqual (matrixTranspose a) b))
           ,TestCase (assertEqual "Self inverting"
                     (True)
                     (matrixEqual (matrixTranspose $ matrixTranspose a) a))
           ,TestCase (assertEqual "Identity"
                     (True)
                     (matrixEqual (matrixTranspose i) i))
           ]
  where
    a = makeMatrix [[0,9,3,0]
                   ,[9,8,0,8]
                   ,[1,8,5,3]
                   ,[0,0,5,8]]
    b = makeMatrix [[0,9,1,0]
                   ,[9,8,8,0]
                   ,[3,0,5,5]
                   ,[0,8,3,8]]
    i = makeIdentity 10

testMatrixDeterminant :: Test
testMatrixDeterminant =
  TestList [TestCase (assertEqual ""
                     (17)
                     (matrixDeterminant a))
           ,TestCase (assertEqual "c00b"
                     (56)
                     (matrixCofactor 0 0 b))
           ,TestCase (assertEqual "c01b"
                     (12)
                     (matrixCofactor 0 1 b))
           ,TestCase (assertEqual "c02b"
                     (-46)
                     (matrixCofactor 0 2 b))
           ,TestCase (assertEqual "det b"
                     (-196)
                     (matrixDeterminant b))
           ,TestCase (assertEqual "c00c"
                     (690)
                     (matrixCofactor 0 0 c))
           ,TestCase (assertEqual "c01c"
                     (447)
                     (matrixCofactor 0 1 c))
           ,TestCase (assertEqual "c02c"
                     (210)
                     (matrixCofactor 0 2 c))
           ,TestCase (assertEqual "c03c"
                     (51)
                     (matrixCofactor 0 3 c))
           ,TestCase (assertEqual "det c"
                     (-4071)
                     (matrixDeterminant c))
           ]
  where
    a = makeMatrix [[1,5]
                   ,[(-3),2]]
    b = makeMatrix [[1,2,6]
                   ,[(-5),8,(-4)]
                   ,[2,6,4]]
    c = makeMatrix [[(-2),(-8),3,5]
                   ,[(-3),1,7,3]
                   ,[1,2,(-9),6]
                   ,[(-6),7,7,(-9)]]

testSubMatrix :: Test
testSubMatrix =
  TestList [TestCase (assertEqual "3x3"
                     (sa)
                     (subMatrix 0 2 a))
           ,TestCase (assertEqual "4x4"
                     (sb)
                     (subMatrix 2 1 b))
           ]
  where
    a = makeMatrix [[1,5,0]
                   ,[(-3),2,7]
                   ,[0,6,(-3)]]
    sa = makeMatrix [[(-3),2]
                   ,[0,6]]
    b = makeMatrix [[(-6),1,1,6]
                   ,[(-8),5,8,6]
                   ,[(-1),0,8,2]
                   ,[(-7),1,(-1),1]]
    sb = makeMatrix [[(-6),1,6]
                    ,[(-8),8,6]
                    ,[(-7),(-1),1]]

testMatrixMinor :: Test
testMatrixMinor =
  TestList [TestCase (assertEqual "Returns expected value"
                     (25)
                     (matrixMinor 1 0 a))
           ,TestCase (assertEqual "Matches determinant in submatrix"
                     (matrixDeterminant $ subMatrix 1 0 a)
                     (matrixMinor 1 0 a))
           ]
  where
    a = makeMatrix [[3,5,0]
                   ,[2,(-1),(-7)]
                   ,[6,(-1),5]]

testMatrixCofactor :: Test
testMatrixCofactor =
  TestList [TestCase (assertEqual "Do not negate"
                     (matrixMinor 0 0 a)
                     (matrixCofactor 0 0 a))
           ,TestCase (assertEqual "Negate"
                     ((-1) * matrixMinor 1 0 a)
                     (matrixCofactor 1 0 a))
           ]
  where
    a = makeMatrix [[3,5,0]
                   ,[2,(-1),(-7)]
                   ,[6,(-1),5]]

testMatrixInvertible :: Test
testMatrixInvertible =
  TestList [TestCase (assertEqual "Is invertible"
                     (True)
                     (matrixInvertible a))
           ,TestCase (assertEqual "Not invertible"
                     (False)
                     (matrixInvertible b))
           ]
  where
    a = makeMatrix [[6,4,4,4]
                   ,[5,5,7,6]
                   ,[4,(-9),3,(-7)]
                   ,[9,1,7,(-6)]]
    b = makeMatrix [[(-4),2,(-2),(-3)]
                   ,[9,6,2,6]
                   ,[0,(-5),1,(-5)]
                   ,[0,0,0,0]]


matrixTests :: [Test]
matrixTests = [testMakeMatrix
              ,testMatrixEqual
              ,testMatrixMult
              ,testMatrixTranspose
              ,testMatrixDeterminant
              ,testSubMatrix
              ,testMatrixMinor
              ,testMatrixCofactor
              ,testMatrixInvertible
              ]
