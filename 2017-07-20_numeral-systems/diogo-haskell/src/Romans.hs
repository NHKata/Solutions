module Romans where

import Prelude hiding (replicate)
import Numeric.Natural
import Text.Megaparsec hiding (State, count)
import Text.Megaparsec.String
import Data.Functor
import Control.Monad
import Control.Monad.State
import Helpers

newtype Roman = Roman String
  deriving Show


natToRoman :: Natural -> Roman
natToRoman nat = evalState natToRomanState nat 

romanToNat :: Roman -> Natural
romanToNat (Roman roman) = either (const 0) id $ parse romanParser "" roman




countOf :: Natural -> State Natural Natural
countOf ammount = do
  remainder <- get
  let count = remainder `div` ammount
  put (remainder `rem` ammount)
  return count

natToRomanState :: State Natural Roman
natToRomanState = do
  ms <- replicate "M"  <$> countOf 1000
  cm <- replicate "CM" <$> countOf 900
  ds <- replicate "D"  <$> countOf 500
  cd <- replicate "CD" <$> countOf 400
  cs <- replicate "C"  <$> countOf 100
  xc <- replicate "XC" <$> countOf 90
  ls <- replicate "L"  <$> countOf 50
  xl <- replicate "XL" <$> countOf 40
  xs <- replicate "X"  <$> countOf 10
  ix <- replicate "IX" <$> countOf 9
  vs <- replicate "V"  <$> countOf 5
  iv <- replicate "IV" <$> countOf 4
  is <- replicate "I"  <$> countOf 1
  return $ Roman $ join $ join [ms, cm, ds, cd, cs, xc, ls, xl, xs, ix, vs, iv, is]



romanParser :: Parser Natural
romanParser = do
  ms <- many $ string "M"  $> 1000
  cm <- many $ string "CM" $> 900
  ds <- many $ string "D"  $> 500
  cd <- many $ string "CD" $> 400
  cs <- many $ string "C"  $> 100
  xc <- many $ string "XC" $> 90
  ls <- many $ string "L"  $> 50
  xl <- many $ string "XL" $> 40
  xs <- many $ string "X"  $> 10
  ix <- many $ string "IX" $> 9
  vs <- many $ string "V"  $> 5
  iv <- many $ string "IV" $> 4
  is <- many $ string "I"  $> 1
  pure $ sum $ join [ms, cm, ds, cd, cs, xc, ls, xl, xs, ix, vs, iv, is]



