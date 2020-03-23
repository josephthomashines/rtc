module Main where

import System.Environment
import System.Exit

import Tracer (parse)

-- Main that passes the args to the parse function
main = getArgs >>= parse >>= putStr . tac
tac  = unlines . reverse . lines

