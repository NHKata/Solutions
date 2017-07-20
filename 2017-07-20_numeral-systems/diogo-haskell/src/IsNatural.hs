{-# LANGUAGE AllowAmbiguousTypes #-}

module IsNatural where

import Numeric.Natural
import Romans
import Urnfields

class IsNatural n where
  toNat   :: n -> Natural
  fromNat :: Natural -> n

instance IsNatural Roman where
  toNat = romanToNat
  fromNat = natToRoman

instance IsNatural Urnfield where
  toNat = urnToNat
  fromNat = natToUrn

instance IsNatural Natural where
  toNat = id
  fromNat = id

convert :: (IsNatural a, IsNatural b) => a -> b
convert = fromNat . toNat
