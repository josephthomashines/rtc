module Light where

import Color
import Point

data PointLight = PointLight {intensity :: Color
                             ,position :: Point
                             }

makePointLight :: Color -> Point -> PointLight
makePointLight i p = PointLight i p


