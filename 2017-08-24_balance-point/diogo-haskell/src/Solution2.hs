module Solution2 where

solve :: [Int] -> Double
solve list = 
  let total = sum list
      mid = fromIntegral total / 2
  in  go list 0 mid 0


go :: [Int] -> Int -> Double -> Int -> Double
go [] _ _ _ = 0
go (x : rest) idx mid leftSum
  | fromIntegral (leftSum + x) > mid  = ((mid - fromIntegral leftSum) / fromIntegral x) + fromIntegral idx
  | otherwise                         = go rest (idx+1) mid (leftSum+x)
