module Tracer where

import System.Environment
import System.Exit

import DemoCanvas
import DemoPoint
import DemoTransform

-- Define how to handle different arguments
parse ["-h"] = usage   >> exit
parse ["-v"] = version >> exit
parse ["--demoPoint"] = demoPoint >> exit
parse ["--demoCanvas"] = demoCanvas "./demoCanvas.ppm" >> exit
parse ["--demoCanvas", fs] = demoCanvas fs >> exit
parse ["--demoTransform"] = demoTransform "./demoTransform.ppm" >> exit
parse ["--demoTransform", fs] = demoTransform fs >> exit

parse ["--demoAll"] = do
  demoPoint
  demoCanvas "./demoCanvas.ppm"
  demoTransform "./demoTransform.ppm"
  exit

-- Fallthrough cases
parse []     = usage >> die ""
parse _     = usage >> die ""

-- Functions called for different arguments
usage   = putStrLn $ unlines
          ["Usage: tracer [ARGS]"
          ,"         -h                     This help page"
          ,"         -v                     Version information"
          ,"         --demoPoint            A simple projectile simulation"
          ,"         --demoCanvas FILE      Draws the projectile simulation to the canvas"
          ]
version = putStrLn "Haskell Ray Tracer 0.1.0.0"
exit    = exitWith ExitSuccess
