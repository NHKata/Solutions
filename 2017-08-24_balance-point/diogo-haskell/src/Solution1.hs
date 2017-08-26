module Solution1 where

import Prelude hiding (head)
import Data.List hiding (head)
import Data.Function
import Data.Maybe

data PointData = PointData {
  value     :: Int,
  leftSum   :: Int,
  rightSum  :: Int,
  index     :: Int
}

solve :: [Int] -> Maybe Double
solve list =
  let leftSums = init $ scanl (+) 0 list                -- calculate the sum to the left of each index, e.g. [1,5,7,2] -> [0,1,6,13]
      rightSums = scanr1 (+) list                       -- calculate the sum to the right of each index + the element at that index, e.g. [1,5,7,2] -> [15,14,9,2]
  in  zipWith4 PointData list leftSums rightSums [0..]  -- zip the values, with the left/right sums and the indices
      & pairs                                           -- pair up adjacent points (e.g. [1,5,7,2] -> [(1,5), (5,7), (7,2)])
      & mapMaybe (uncurry findBalance)                  -- runs `findBalance` for every pair, discarding results where no balance point was found
      & head                                            -- returns the first result

-- pair up adjacent points (e.g. [1,5,7,2] -> [(1,5), (5,7), (7,2)])
pairs :: [a] -> [(a, a)]
pairs (x : y : rest)  = (x, y) : pairs (y : rest)
pairs _               = []

head :: [a] -> Maybe a
head = listToMaybe

findBalance :: PointData -> PointData -> Maybe Double
findBalance x y
  | leftSum y > rightSum y || rightSum y == value y =
      let total = leftSum x + rightSum x
          mid = fromIntegral total / 2
      in  Just $ ((mid - asDouble leftSum x) / asDouble value x) + asDouble index x
  | otherwise = Nothing

-- converts a function that returns an integral `a` into a function that returns a `Double`
asDouble :: Integral b => (a -> b) -> (a -> Double)
asDouble f = fromIntegral . f
