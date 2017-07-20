module Bowlng_Scores_2 where

bowling_scores :: (Eq a , Num a) => [[a]] -> a
bowling_scores = points.flat

points :: (Eq a , Num a) => [a] -> a
points [] = 0
points [a] = a
points [a,b] = a+b
points [a,b,c] = a+b+c
points (a:b:c:rlist)
   | a == 10 = 10 + b + c + points( b:c:rlist)
   | (a+b) == 10 = 10 + c + points(c:rlist)
   | otherwise = a + b + points(c:rlist)


flat :: (Eq a , Num a) => [[a]] -> [a]
flat = foldl concatFilter []

concatFilter :: (Eq a , Num a) => [a] -> [a] -> [a]
concatFilter a [10,0] = a ++ [10]
concatFilter a b = (++) a b


-- TESTS --

t1 :: Bool
t1 = (bowling_scores [[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,10,10]] ) == 300

t2 :: Bool
t2 = (bowling_scores [[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[0,0]] ) == 240

t3 :: Bool
t3 = (bowling_scores [[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6,4]] ) == 140

t4 :: Bool
t4 = ( bowling_scores [[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3]] ) == 60

t5 :: Bool
t5 = ( bowling_scores [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]] ) == 0
