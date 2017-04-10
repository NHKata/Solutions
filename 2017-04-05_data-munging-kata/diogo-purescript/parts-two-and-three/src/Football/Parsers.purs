module Football.Parsers
  ( parser
  ) where

import Prelude
import Common.Parsers (StringParser, eol, skipTillEol, tokens, parseRows)
import Data.Array (some)
import Data.Maybe (Maybe(..))
import Football.Types (Team(..))
import Text.Parsing.Parser.String (char, skipSpaces, string)

parser :: StringParser (Array Team)
parser = parseRows { header, row: teamData, footer: Nothing, separator }

-- parser that consumes the header line, without returning anything
header :: StringParser Unit
header = skipSpaces *> string "Team" *> skipSpaces *> char 'P' *> skipSpaces *> char 'W' *> skipTillEol

-- parses a line, returning a team's data
teamData :: StringParser Team
teamData = do
  position    <- skipSpaces *> tokens.natural <* char '.'
  name        <- skipSpaces *> tokens.identifier
  games       <- skipSpaces *> tokens.natural 
  wins        <- skipSpaces *> tokens.natural 
  losses      <- skipSpaces *> tokens.natural 
  draws       <- skipSpaces *> tokens.natural 
  for         <- skipSpaces *> tokens.natural 
  _           <- skipSpaces *> char '-'
  against     <- skipSpaces *> tokens.natural 
  points      <- skipSpaces *> tokens.natural
  pure $ Team { position, name, games, wins, losses, draws, for, against, points }

-- parser that consumes a sequence of '-', without returning anything
separator :: StringParser Unit
separator = skipSpaces *> some (char '-') *> eol
