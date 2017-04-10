module Common.Parsers 
  ( StringParser
  , parseRows
  , eol
  , emptyLine
  , skipTillEol
  , number
  , alphaNumericString
  , tokens
  ) where

import Prelude
import Control.Plus ((<|>))
import Data.Array (many, some)
import Data.Either (either)
import Data.Int (toNumber)
import Data.Maybe (fromMaybe, Maybe)
import Data.String (fromCharArray)
import Text.Parsing.Parser (Parser)
import Text.Parsing.Parser.Combinators (try, optional, manyTill)
import Text.Parsing.Parser.Language (emptyDef)
import Text.Parsing.Parser.String (anyChar, char, eof, oneOf)
import Text.Parsing.Parser.Token (TokenParser, alphaNum, makeTokenParser)

type StringParser a = Parser String a

type ParserData a header row footer separator = {
  header    :: Parser a header,
  row       :: Parser a row,
  separator :: Parser a separator,
  footer    :: Maybe (Parser a footer)
}

parseRows :: forall a header row footer separator
          .  ParserData a header row footer separator
          -> Parser a (Array row)
parseRows p = 
  p.header *> some row <* footer
  where
    row = try (optional (try p.separator) *> p.row)
    footer = fromMaybe (pure unit) (void <$> p.footer)


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

