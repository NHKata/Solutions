module Bowling_Scores where

-- f0,f1 | f01 --> points/pins multiplier factor
-- r0,r1,r2 --> roling points/pins
frame_step (f0,f1) [10,0] = (f0*10,(f1+1,2))
frame_step (f0,f1) [r0,r1]
  | r0+r1 == 10 = (f0*r0+f1*r1,(2,1))
  | otherwise = (f0*r0+f1*r1,(1,1))
frame_step f01 [r0,r1,r2] = (((+) r2).fst $ frame_step f01 [r0,r1],(0,0))


frames_chainning (points_before,multipliers_before) frame_knocked_pins =
  let (points, multipliers_after) = frame_step multipliers_before frame_knocked_pins
  in (points_before+points, multipliers_after)


frames_iterator = foldl frames_chainning (0,(1,1))


bowling_scores = fst.frames_iterator


-- // TEST //

tst = [t1,t2,t3,t4,t5,t6,t7,t8,t9]

--
allZero = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
allZeroR = 0
t1 = ((==) allZeroR) $ bowling_scores allZero

--
allThree = [[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3]]
allThreeR = 60
t2 = ((==) allThreeR) $ bowling_scores allThree

--
allSpares = [[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6,4]]
allSparesR = 140
t3 = ((==) allSparesR) $ bowling_scores allSpares

--
nineStrikes =[[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[0,0]]
nineStrikesR = 240
t4 = ((==) nineStrikesR) $ bowling_scores nineStrikes

--
perfectGame = [[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,10,10]]
perfectGameR = 300
t5 = ((==) perfectGameR) $ bowling_scores perfectGame

--
t6DS = [[5,5],[7,1],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[10,10,10]]
t6R = 97
t6 = ((==) t6R) $ bowling_scores t6DS

--
t7DS = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[10,0],[10,10,10]]
t7R = 60
t7 = ((==) t7R) $ bowling_scores t7DS

--
t8DS = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,10],[5,5],[10,0,10]]
t8R = 55
t8 = ((==) t8R) $ bowling_scores t8DS

--
t9DS = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,10],[5,5],[0,10,10]]
t9R = 45
t9 = ((==) t9R) $ bowling_scores t9DS
