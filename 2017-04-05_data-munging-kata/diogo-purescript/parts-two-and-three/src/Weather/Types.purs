module Weather.Types where

newtype Day = Day {
  day     :: Int,
  maxTemp :: Number,
  minTemp :: Number
}
