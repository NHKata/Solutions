module LiftInt(LiftInt,liftInt,putInt) where
   class LiftInt a where
      liftInt :: a -> Int
      putInt :: Int -> a

   instance LiftInt Int where
      liftInt = id
      putInt = id
