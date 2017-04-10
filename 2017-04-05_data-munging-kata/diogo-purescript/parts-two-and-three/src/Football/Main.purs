module Football where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Array (head, sortBy)
import Data.Maybe (Maybe(..))
import Data.Ord (abs)
import Football.Parsers (parser)
import Football.Types (Team(..))
import IOHelpers (processRows)
import Node.FS (FS)

-- |
-- | I/O
-- | 
main :: forall e. Eff (console :: CONSOLE, fs :: FS, err :: EXCEPTION | e) Unit
main = processRows "data/football.dat" parser process

process :: forall e. Array Team -> Eff (console :: CONSOLE | e) Unit
process teams =
  case smallestGoalDiff teams of
    Nothing         -> log "No team data found"
    Just (Team t)   -> log $ "Team with smallest goal difference: " <> show t.name

-- |
-- | BUSINESS LOGIC
-- | 
smallestGoalDiff :: Array Team -> Maybe Team
smallestGoalDiff teams = head sortedTeams
  where
    sortedTeams = sortBy (comparing goalDiff) teams
    goalDiff (Team t) = abs $ t.for - t.against
