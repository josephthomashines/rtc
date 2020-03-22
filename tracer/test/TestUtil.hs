module TestUtil where

import Test.HUnit
import Util

testFloatEqual :: Test
testFloatEqual =
  TestList [TestCase (assertEqual "Should equal"
                     (floatEqual 1.0 1.000001) (True))
           ,TestCase (assertEqual "Should not equal"
                     (floatEqual 1.0 1.001) (False))
           ]

utilTests :: [Test]
utilTests = [testFloatEqual
            ]
