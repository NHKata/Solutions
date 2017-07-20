module Urnfields where

import Prelude hiding (replicate)
import Numeric.Natural
import Helpers
import Data.List (genericLength)

newtype Urnfield = Urnfield String

instance Show Urnfield where
  show (Urnfield s) = s

urnToNat :: Urnfield -> Natural
urnToNat (Urnfield urn) = 
  let fives = genericLength $ filter (== '\\') urn
      ones  = genericLength $ filter (== '/')  urn
  in fives * 5 + ones

natToUrn :: Natural -> Urnfield
natToUrn nat = 
  let fives = nat `div` 5
      ones  = nat `rem` 5
  in Urnfield (replicate '/' ones ++ replicate '\\' fives)




