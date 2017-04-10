module Football.Types where

newtype Team = Team {
  position    :: Int,
  name        :: String,
  games       :: Int,
  wins        :: Int,
  losses      :: Int,
  draws       :: Int,
  for         :: Int,
  against     :: Int,
  points      :: Int      
}
