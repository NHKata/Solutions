module IOHelpers 
  ( processRows
  ) where

import Prelude
import Common.Parsers (StringParser)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Either (Either(..))
import Node.Encoding (Encoding(..))
import Node.FS (FS)
import Node.FS.Sync (readTextFile)
import Node.Path (FilePath)
import Text.Parsing.Parser (runParser)

type Effects e = Eff (console :: CONSOLE, fs :: FS, err :: EXCEPTION | e)

processRows :: forall e row
            .  FilePath -> StringParser (Array row) -> (Array row -> Effects e Unit)
            -> Effects e Unit
processRows path parser action = do
  text <- readTextFile UTF8 path
  case runParser text parser of
    Left err    -> logShow err
    Right rows  -> action rows

