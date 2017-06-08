module Main where

import Prelude
import Data.List as List
import Data.Foldable (sum)
import Data.List (List(Nil), fromFoldable, (:))
import Partial (crash)
import Partial.Unsafe (unsafePartial)


type Roll = Int
type Frame = Array Roll

score :: Array (Array Int) -> Int
score frames = score' $ removeNonRolls $ fromFoldable frames

-- removes any dummy zeroes from a list of frames
-- e.g. if a frames with a strike is represented as [10, 0], it'll be converted to just [10]
removeNonRolls :: List Frame -> List Frame
removeNonRolls frames = map remove frames
  where
    remove [10, 0] = [10]
    remove x       = x

score' :: List Frame -> Int
score' Nil                = 0
score' ([x, y, z] : Nil)  = x + y + z
score' ([10] : rest)      = 10 + (sum $ takeRolls 2 rest) + score' rest
score' ([x, y] : rest)
  | x + y == 10           = 10 + (sum $ takeRolls 1 rest) + score' rest
  | otherwise             = x + y + score' rest
score' _                  = unsafePartial $ crash

-- take the next n rolls from a list of frames
takeRolls :: Int -> List Frame -> List Roll
takeRolls n frames = List.take n (frames >>= fromFoldable)






