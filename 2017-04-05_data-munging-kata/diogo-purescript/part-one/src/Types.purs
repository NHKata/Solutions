module Types where

newtype WeatherData = WeatherData {
  days      :: Array Day,
  monthAvg  :: MonthAvg
}

newtype MonthAvg = MonthAvg {
  maxTemp :: Number,
  minTemp :: Number
}

newtype Day = Day {
  day     :: Int,
  maxTemp :: Number,
  minTemp :: Number
}
