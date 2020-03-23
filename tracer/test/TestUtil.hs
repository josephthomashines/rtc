module TestUtil where

import Test.HUnit
import Util

testFloatEqual :: Test
testFloatEqual =
  TestList [TestCase (assertEqual "Should equal"
                     (True)
                     (floatEqual 1.0 1.000001)
                     )
           ,TestCase (assertEqual "Should not equal"
                     (False)
                     (floatEqual 1.0 1.001)
                     )
           ]

utilTests :: [Test]
utilTests = [testFloatEqual
            ]
