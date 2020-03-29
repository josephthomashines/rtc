module Transform where

import Matrix
import Util

-- A transformation is just a matrix
type Transform = Matrix

makeTranslation :: Float -> Float -> Float -> Matrix
makeTranslation x y z =
  makeMatrix [[1,0,0,x]
             ,[0,1,0,y]
             ,[0,0,1,z]
             ,[0,0,0,1]]

makeScale :: Float -> Float -> Float -> Matrix
makeScale x y z =
  makeMatrix [[x,0,0,0]
             ,[0,y,0,0]
             ,[0,0,z,0]
             ,[0,0,0,1]]

makeRotX :: Float -> Matrix
makeRotX r =
  makeMatrix [[1,0,0,0]
             ,[0,cos r,-1 * (sin r),0]
             ,[0,sin r,cos r,0]
             ,[0,0,0,1]]

makeRotY :: Float -> Matrix
makeRotY r =
  makeMatrix [[cos r,0,sin r, 0]
             ,[0,1,0,0]
             ,[-1 * (sin r),0,cos r,0]
             ,[0,0,0,1]]

makeRotZ :: Float -> Matrix
makeRotZ r =
  makeMatrix [[cos r,-1 * (sin r),0,0]
             ,[sin r,cos r,0,0]
             ,[0,0,1,0]
             ,[0,0,0,1]]

makeShear :: Float -> Float -> Float -> Float -> Float -> Float -> Matrix
makeShear xy xz yx yz zx zy =
  makeMatrix [[1,xy,xz,0]
             ,[yx,1,yz,0]
             ,[zx,zy,1,0]
             ,[0,0,0,1]]
