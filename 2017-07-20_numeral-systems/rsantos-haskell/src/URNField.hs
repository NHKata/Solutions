module URNField(URNField(URNField)) where

   import LiftInt

   newtype URNField = URNField Int

   instance Show URNField where
      show (URNField x) = let (bs,fs) = divMod x 5
                          in (replicate fs '/')++(replicate bs '\\' )

   instance Read URNField where
      readsPrec _ input = let (word,input') = span (\x -> elem x tokens) input
                          in [(URNField $ foldl (\x y -> x + charValue y) 0 word,input')]

   tokens :: [Char]
   tokens = "/\\"

   charValue :: Char -> Int
   charValue '/' = 1
   charValue '\\' = 5
   charValue _ = error "invalid char"


   instance LiftInt URNField where
      liftInt (URNField value) = value
      putInt = URNField
