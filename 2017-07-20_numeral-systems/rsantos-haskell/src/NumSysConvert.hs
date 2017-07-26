module NumSysConvert(convert) where

import LiftInt

convert :: (LiftInt a, LiftInt b) => a -> b
convert = putInt.liftInt
