module Color where

import Util (floatEqual)

-- Data type for RGB color
data Color = Color {r :: !Float
                   ,g :: !Float
                   ,b :: !Float
                   }
  deriving (Show)

-- Rough float equal for Color
instance Eq Color where
  c1 == c2 = (floatEqual (r c1) (r c2))
          && (floatEqual (g c1) (g c2))
          && (floatEqual (b c1) (b c2))

-- Make color, keep consistent interface
makeColor :: Float -> Float -> Float -> Color
makeColor r g b = Color r g b

black :: Color
black = makeColor 0 0 0

white :: Color
white = makeColor 1 1 1

-- Add colors
addColors :: Color -> Color -> Color
addColors c1@(Color !r1 !g1 !b1) c2@(Color !r2 !g2 !b2) = makeColor nr ng nb
  where
    nr = r1 + r2
    ng = g1 + g2
    nb = b1 + b2

-- Subtract colors
subColors :: Color -> Color -> Color
subColors c1@(Color !r1 !g1 !b1) c2@(Color !r2 !g2 !b2) = makeColor nr ng nb
  where
    nr = r1 - r2
    ng = g1 - g2
    nb = b1 - b2

-- Multiply (blend) colors
multColors :: Color -> Color -> Color
multColors c1@(Color !r1 !g1 !b1) c2@(Color !r2 !g2 !b2) = makeColor nr ng nb
  where
    nr = r1 * r2
    ng = g1 * g2
    nb = b1 * b2

-- Scale color
scaleColor :: Float -> Color -> Color
scaleColor s c@(Color !cr !cg !cb) = makeColor nr ng nb
  where
    nr = s * cr
    ng = s * cg
    nb = s * cb
