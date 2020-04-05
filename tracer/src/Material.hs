module Material where

import Color

import Util

data Material = Material {color :: Color
                         ,ambient :: Float
                         ,diffuse :: Float
                         ,specular :: Float
                         ,shininess :: Float
                         }
  deriving (Show)

-- Use float equal for comparison
instance Eq Material where
  a == b =
    colMatch && ambMatch && diffMatch && specMatch && shinMatch
    where
      colMatch = (color a) == (color b)
      ambMatch = floatEqual (ambient a) (ambient b)
      diffMatch = floatEqual (diffuse a) (diffuse b)
      specMatch = floatEqual (specular a) (specular b)
      shinMatch = floatEqual (shininess a) (shininess b)

-- The default material
defaultMaterial :: Material
defaultMaterial =
  Material color 0.1 0.9 0.9 200.0
  where
    color = makeColor 1 1 1

-- Setters
materialColor :: Material -> Color -> Material
materialColor m co =
  Material co am di sp sh
  where
    am = ambient m
    di = diffuse m
    sp = specular m
    sh = shininess m

materialAmbient :: Material -> Float -> Material
materialAmbient m am =
  Material co am di sp sh
  where
    co = color m
    di = diffuse m
    sp = specular m
    sh = shininess m

materialDiffuse :: Material -> Float -> Material
materialDiffuse m di =
  Material co am di sp sh
  where
    co = color m
    am = ambient m
    sp = specular m
    sh = shininess m

materialSpecular :: Material -> Float -> Material
materialSpecular m sp =
  Material co am di sp sh
  where
    co = color m
    am = ambient m
    di = diffuse m
    sh = shininess m

materialShininess :: Material -> Float -> Material
materialShininess m sh =
  Material co am di sp sh
  where
    co = color m
    am = ambient m
    di = diffuse m
    sp = specular m
