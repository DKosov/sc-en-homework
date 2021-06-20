module Main where

import Data.Maybe (mapMaybe)
import System.Environment (getArgs)
import Text.Read (readMaybe)

half :: [Int] -> ([Int], [Int])
half xs = splitAt ((length xs) `div` 2) xs

left :: [Int] -> [Int]
left xs = fst (half xs)

right :: [Int] -> [Int]
right xs = snd (half xs)

merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys

msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort x = merge (msort (left x)) (msort (right x))

main :: IO ()
main = do
  args <- getArgs

  print (msort (mapMaybe readMaybe args))
