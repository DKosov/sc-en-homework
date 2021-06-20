module Main where

import Lib (hLength)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  mapM_ (print . hLength) args
