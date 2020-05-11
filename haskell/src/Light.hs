module Light where

import Color
import Material
import Point

data PointLight = PointLight {intensity :: !Color
                             ,position :: !Point
                             }

makePointLight :: Color -> Point -> PointLight
makePointLight !i !p = PointLight i p

-- Calculate the lighting
lighting :: Material -> PointLight -> Point -> Point -> Point -> Color
lighting
  m@(Material !materialColor !materialAmbient !materialDiffuse !materialSpecular !materialShininess)
  pl@(PointLight !lightIntensity !lightPosition) !pos !eyeV !normV
  | lightDotNormal < 0  = addColors ambient1 sol1
  | reflectDotEye < 0 = addColors ambient1 sol2
  | otherwise         = addColors ambient1 sol3
  where
    !diffuse1 = black
    !specular1 = black
    !effectiveColor = multColors materialColor lightIntensity
    !lightV = normalizePoint $ subPoints lightPosition pos
    !ambient1 = scaleColor materialAmbient effectiveColor
    !lightDotNormal = dotPoints lightV normV
    !diffuse2 = scaleColor (materialDiffuse * lightDotNormal) effectiveColor
    !reflectV = reflectVector normV $ negPoint lightV
    !reflectDotEye = dotPoints reflectV eyeV
    !specularFactor = reflectDotEye ** materialShininess
    !specular2 = scaleColor (materialSpecular * specularFactor) lightIntensity
    !sol1 = addColors diffuse1 specular1
    !sol2 = addColors diffuse2 specular1
    !sol3 = addColors diffuse2 specular2
