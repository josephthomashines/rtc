module Sphere where

data Sphere = Sphere {id :: Int
                     }
  deriving (Eq,Show)

-- TODO: Generic object + more data
makeSphere :: Int -> Sphere
makeSphere id = Sphere id
