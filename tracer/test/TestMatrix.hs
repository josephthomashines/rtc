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

matrixTests :: [Test]
matrixTests = [testMakeMatrix
              ,testMatrixEqual
              ,testMatrixMult
              ]
