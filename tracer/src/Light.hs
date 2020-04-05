module Light where

import Color
import Material
import Point

data PointLight = PointLight {intensity :: Color
                             ,position :: Point
                             }

makePointLight :: Color -> Point -> PointLight
makePointLight i p = PointLight i p

-- Calculate the lighting
lighting :: Material -> PointLight -> Point -> Point -> Point -> Color
lighting m pl pos eyeV normV
  | lightDotNormal < 0  = addColors ambient1 $ addColors diffuse1 specular1
  | reflectDotEye < 0 = addColors ambient1 $ addColors diffuse2 specular1
  | otherwise         = addColors ambient1 $ addColors diffuse2 specular2
  where
    diffuse1 = black
    specular1 = black
    materialColor = color m
    lightIntensity = intensity pl
    effectiveColor = multColors materialColor lightIntensity
    lightPosition = position pl
    lightV = normalizePoint $ subPoints lightPosition pos
    materialAmbient = ambient m
    materialDiffuse = diffuse m
    ambient1 = scaleColor materialAmbient effectiveColor
    lightDotNormal = dotPoints lightV normV
    diffuse2 = scaleColor (materialDiffuse * lightDotNormal) effectiveColor
    reflectV = reflectVector normV $ negPoint lightV
    reflectDotEye = dotPoints reflectV eyeV
    materialShininess = shininess m
    materialSpecular = specular m
    specularFactor = reflectDotEye ** materialShininess
    specular2 = scaleColor (materialSpecular * specularFactor) lightIntensity
