module Color where

import Util (floatEqual)

-- Data type for RGB color
data Color = Color {r :: Float
                   ,g :: Float
                   ,b :: Float
                   }
  deriving (Show)

-- Rough float equal for Color
instance Eq Color where
  c1 == c2 = (floatEqual (r c1) (r c2))
          && (floatEqual (g c1) (g c2))
          && (floatEqual (b c1) (b c2))

-- Add colors
addColors :: Color -> Color -> Color
addColors c1 c2 = Color nr ng nb
  where
    nr = (r c1) + (r c2)
    ng = (g c1) + (g c2)
    nb = (b c1) + (b c2)

-- Subtract colors
subColors :: Color -> Color -> Color
subColors c1 c2 = Color nr ng nb
  where
    nr = (r c1) - (r c2)
    ng = (g c1) - (g c2)
    nb = (b c1) - (b c2)

-- Multiply (blend) colors
multColors :: Color -> Color -> Color
multColors c1 c2 = Color nr ng nb
  where
    nr = (r c1) * (r c2)
    ng = (g c1) * (g c2)
    nb = (b c1) * (b c2)

-- Scale color
scaleColor :: Float -> Color -> Color
scaleColor s c = Color nr ng nb
  where
    nr = s * (r c)
    ng = s * (g c)
    nb = s * (b c)
