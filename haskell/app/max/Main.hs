module Main where

import Data.Maybe (mapMaybe)
import Lib (hMax)
import System.Environment (getArgs)
import Text.Read (readMaybe)

main :: IO ()
main = do
  args <- getArgs
  print (hMax (mapMaybe readMaybe args))
