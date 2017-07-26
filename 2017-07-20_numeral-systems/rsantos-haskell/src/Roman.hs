module Roman(Roman(Roman)) where

   import LiftInt

   newtype Roman = Roman Int

   instance Show Roman where
      show (Roman x) = renderRoman 1 x

   instance Read Roman where
      readsPrec _ input = let (word,input') = span (\x -> elem x tokens) input
                          in [(Roman $ parse word,input')]

   tokens :: [Char]
   tokens = "IVXLCDM"

   charValue :: Char -> Int
   charValue 'I' = 1
   charValue 'V' = 5
   charValue 'X' = 10
   charValue 'L' = 50
   charValue 'C' = 100
   charValue 'D' = 500
   charValue 'M' = 1000
   charValue _ = error "invalid char"

   showRomanSymbols' :: Int -> Int -> [Char]
   showRomanSymbols' offSet value
      | value <= 3 = replicate value (tokens !! (offSet-1))
      | value == 4 = (tokens !! (offSet-1)):(tokens !! offSet):[]
      | value <= 8 = (tokens !! offSet):(replicate (value-5) (tokens !! (offSet-1)))
      | value == 9 = (tokens !! (offSet-1)):(tokens !! (offSet+1)):[]
      | otherwise = error "invalid"

   renderRoman :: Int -> Int -> String
   renderRoman _ 0 = ""
   renderRoman offSet value = let (i,r) = divMod value 10
                              in (renderRoman (offSet+2) i ) ++ (showRomanSymbols' offSet r )

   parse :: String -> Int
   parse [] = 0
   parse [c] = charValue c
   parse (c0:c1:s) = let v0 = charValue c0
                         v1 = charValue c1
                         vs = parse (c1:s)
                     in if v1 > v0
                         then (v0*(-1))+vs
                         else v0+vs

   instance LiftInt Roman where
      liftInt (Roman value) = value
      putInt = Roman
