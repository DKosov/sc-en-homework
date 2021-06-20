module Main where

import Data.Maybe (mapMaybe)
import Lib (hSortMin)
import System.Environment (getArgs)
import Text.Read (readMaybe)

main :: IO ()
main = do
  args <- getArgs
  print (hSortMin (mapMaybe readMaybe args))
