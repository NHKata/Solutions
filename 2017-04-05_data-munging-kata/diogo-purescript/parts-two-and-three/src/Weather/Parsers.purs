module Weather.Parsers 
  ( parser
  ) where

import Prelude
import Common.Parsers (StringParser, emptyLine, number, parseRows, skipTillEol, tokens)
import Data.Maybe (Maybe(..))
import Text.Parsing.Parser.Combinators (optional)
import Text.Parsing.Parser.String (char, skipSpaces, string)
import Weather.Types (Day(..))

parser :: StringParser (Array Day)
parser = parseRows { header, row: dayData, footer: Just monthData, separator: emptyLine }

-- parses a line, returning weather data for a day
dayData :: StringParser Day
dayData = do
  day     <- skipSpaces *> tokens.natural
  maxTemp <- skipSpaces *> number <* optional (char '*')
  minTemp <- skipSpaces *> number <* optional (char '*')
  _       <- skipTillEol
  pure $ Day { day, maxTemp, minTemp }

-- parses that consumes a line with weather data for a month, without returning anything
monthData :: StringParser Unit
monthData = skipSpaces *> string "mo" *> skipTillEol

-- parser that consumes the header line, without returning anything
header :: StringParser Unit
header = skipSpaces *> string "Dy" *> skipSpaces *> string "MxT" *> skipTillEol
