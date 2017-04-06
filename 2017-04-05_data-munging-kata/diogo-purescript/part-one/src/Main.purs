module Main where

import Prelude
import Types (Day(..), WeatherData(..)) 
import Parsers (parser)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Array (head, sortBy)
import Data.Either (either)
import Data.Maybe (Maybe(..))
import Node.Encoding (Encoding(..))
import Node.FS (FS)
import Node.FS.Sync (readTextFile)
import Text.Parsing.Parser (ParseError, runParser)

-- |
-- | I/O
-- | 
main :: forall e. Eff (console :: CONSOLE, fs :: FS, err :: EXCEPTION | e) Unit
main = do
  text <- readTextFile UTF8 "data/weather.dat"
  let parseResult = runParser text parser
  either logError process parseResult

process :: forall e. WeatherData -> Eff (console :: CONSOLE | e) Unit
process weather =
  case smallestTempSpread weather of
    Nothing       -> log "No weather data found"
    Just (Day d)  -> log $ "Day with smallest temperature spread: " <> show d.day

logError :: forall e. ParseError -> Eff (console :: CONSOLE | e) Unit
logError = logShow


-- |
-- | BUSINESS LOGIC
-- | 
smallestTempSpread :: WeatherData -> Maybe Day
smallestTempSpread (WeatherData weather) =
  head sortedDays
  where
    sortedDays = sortBy (comparing tempSpread) weather.days
    tempSpread (Day d) = d.maxTemp - d.minTemp

