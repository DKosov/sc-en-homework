module Main where

import Lib (hLength, hMax)
import qualified Test.Hspec as H
import qualified Test.QuickCheck as QC

main :: IO ()
main = H.hspec $ do
  H.describe "hLength" $ do
    assertAgreesWithLength
  H.describe "hMax" $ do
    assertAgreesWithMaximum

assertAgreesWithLength :: H.SpecWith ()
assertAgreesWithLength =
  makeAssertion "agrees with Prelude length" 10000 agreesWithLength

assertAgreesWithMaximum :: H.SpecWith ()
assertAgreesWithMaximum =
  makeAssertion "agrees with Prelude maximum" 10000 agreesWithMaximum

makeAssertion :: QC.Testable p => String -> Int -> p -> H.SpecWith ()
makeAssertion label n prop = H.it label $ QC.withMaxSuccess n prop

agreesWithLength :: QC.ASCIIString -> QC.Property
agreesWithLength (QC.ASCIIString s) =
  '\NUL' `notElem` s QC.==> length s == hLength s

agreesWithMaximum :: QC.NonEmptyList Int -> Bool
agreesWithMaximum (QC.NonEmpty l) = maximum l == hMax l
