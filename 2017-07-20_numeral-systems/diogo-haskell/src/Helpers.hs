module Helpers where

import Data.List

replicate :: Integral n => a -> n -> [a]
replicate = flip genericReplicate 

printAll :: Show a => [a] -> IO ()
printAll = mapM_ print
