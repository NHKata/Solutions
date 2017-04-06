module Parsers 
    ( parser
    ) where

import Prelude
import Types (Day(..), WeatherData(..), MonthAvg(..))
import Control.Plus ((<|>))
import Data.Array (many, some)
import Data.Either (either)
import Data.Int (toNumber)
import Data.String (fromCharArray)
import Text.Parsing.Parser (Parser)
import Text.Parsing.Parser.Combinators (try, optional, manyTill)
import Text.Parsing.Parser.Language (emptyDef)
import Text.Parsing.Parser.String (anyChar, char, eof, oneOf, skipSpaces, string)
import Text.Parsing.Parser.Token (TokenParser, alphaNum, makeTokenParser)

type StringParser a = Parser String a

parser :: StringParser WeatherData
parser = do
  _         <- header
  _         <- emptyLine
  days      <- some $ try dayData
  monthAvg  <- monthData
  pure $ WeatherData { days, monthAvg } 

-- parses a line, returning weather data for a day
dayData :: StringParser Day
dayData = do
  day     <- skipSpaces *> tokens.natural
  maxTemp <- skipSpaces *> number <* optional (char '*')
  minTemp <- skipSpaces *> number <* optional (char '*')
  _       <- skipTillEol
  pure $ Day { day, maxTemp, minTemp }

-- parses a line, returning weather data for a month
monthData :: StringParser MonthAvg
monthData = do
  _       <- skipSpaces *> string "mo"
  maxTemp <- skipSpaces *> number <* optional (char '*')
  minTemp <- skipSpaces *> number <* optional (char '*')
  _       <- skipTillEol
  pure $ MonthAvg { maxTemp, minTemp }

-- parser that consumes the header line, without returning anything
header :: StringParser Unit
header = skipSpaces *> string "Dy" *> skipSpaces *> string "MxT" *> skipTillEol

-- parser that consumes an end of line character
eol :: StringParser Unit
eol = void $ optional (char '\r') *> char '\n'

-- parser that consumes an empty line
emptyLine :: StringParser Unit
emptyLine = many (oneOf [' ', '\t']) *> eol

-- parser that consumes all characters until it finds an end of line/end of file character
skipTillEol :: StringParser Unit
skipTillEol = void $ manyTill anyChar (try eol <|> eof)

-- parser that consumes an integer or float, and returns it
number :: StringParser Number
number = (either toNumber id) <$> tokens.naturalOrFloat

-- parser that consumes an alphanumeric string, and returns it
alphaNumericString :: StringParser String
alphaNumericString = fromCharArray <$> many alphaNum

tokens :: TokenParser
tokens = makeTokenParser emptyDef