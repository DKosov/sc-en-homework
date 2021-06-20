{-# LANGUAGE ForeignFunctionInterface #-}

module Lib where

import Foreign (Ptr, free, newArray)
import Foreign.C.String (withCString)
import Foreign.C.Types (CChar, CInt (CInt), CSize (CSize))
import System.IO.Unsafe (unsafePerformIO)

foreign import ccall "length" c_length :: Ptr CChar -> IO CSize

foreign import ccall "max" c_max :: CSize -> Ptr CInt -> IO CInt

foreign import ccall "hsortmin" c_hsortmin :: CSize -> Ptr CInt -> IO CInt


hLength :: String -> Int
{-# NOINLINE hLength #-}
hLength string = unsafePerformIO $ do
  result <- withCString string c_length
  return (fromIntegral result)

hMax :: [Int] -> Int
{-# NOINLINE hMax #-}
hMax list = unsafePerformIO $ do
  let n = fromIntegral (length list)
  p <- newArray (map fromIntegral list)
  result <- c_max n p
  free p
  return (fromIntegral result)

hSortMin :: [Int] -> Int
{-# NOINLINE hSortMin #-}
hSortMin list = unsafePerformIO $ do
  let n = fromIntegral (length list)
  p <- newArray (map fromIntegral list)
  result <- c_hsortmin n p
  free p
  return (fromIntegral result)
