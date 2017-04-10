module Weather where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Array (head, sortBy)
import Data.Maybe (Maybe(..))
import IOHelpers (processRows)
import Node.FS (FS)
import Weather.Parsers (parser)
import Weather.Types (Day(..))

-- |
-- | I/O
-- | 
main :: forall e. Eff (console :: CONSOLE, fs :: FS, err :: EXCEPTION | e) Unit
main = processRows "data/weather.dat" parser process

process :: forall e. Array Day -> Eff (console :: CONSOLE | e) Unit
process weather =
  case smallestTempSpread weather of
    Nothing       -> log "No weather data found"
    Just (Day d)  -> log $ "Day with smallest temperature spread: " <> show d.day

-- |
-- | BUSINESS LOGIC
-- | 
smallestTempSpread :: Array Day -> Maybe Day
smallestTempSpread days =
  head sortedDays
  where
    sortedDays = sortBy (comparing tempSpread) days
    tempSpread (Day d) = d.maxTemp - d.minTemp

