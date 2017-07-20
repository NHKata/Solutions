module MainK where

toURNF x = (rep (mod x 5) "/")++(rep (div x 5) ((:) '\\' ""))

rep 0 _ = ""
rep n x = x++(rep (n-1) x)

ssymb :: Integer -> String -> String -> String ->String
ssymb x s1 s2 s3
   | x <= 3 = rep x s1
   | x == 4 = s1++s2
   | x <= 8 = s2 ++(rep (x-5) s1)
   | x == 9 = s1++s3
   | otherwise = error "invalid"

symbols = ["I","V","X","L","C","D","M","?","@"]

powaToSymb :: Integer -> [String]
powaToSymb x = take 3 (drop  (truncate((logBase 10 (fromInteger x)))*2) symbols)

toRom :: Integer -> String
toRom x | x < 10 = let [a,b,c] = powaToSymb x
                  in ssymb (read (take 1 (show x))) a b c
        | otherwise = let [a,b,c] = powaToSymb x ;
                          (h:t) = show x
                     in ssymb (read [h]) a b c ++ toRom (read t)
