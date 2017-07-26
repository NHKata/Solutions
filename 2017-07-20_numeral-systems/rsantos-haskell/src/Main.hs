module Main where

import LiftInt
import Roman
import URNField
import NumSysConvert

main :: IO ()
main = putStrLn "Hello, Haskell!"


-- examples / test

r30r = ((convert :: Roman->Roman).read) "XXX"
r30i = ((convert :: Roman->Int).read) "XXX"
r30u = ((convert :: Roman->URNField).read) "XXX"

i31r = ((convert :: Int->Roman).read) "31"
i31i = ((convert :: Int->Int).read) "31"
i31u = ((convert :: Int->URNField).read) "31"

u7r = ((convert :: URNField->Roman).read) "//\\"
u7i = ((convert :: URNField->Int).read) "//\\"
u7u = ((convert :: URNField->URNField).read) "//\\"
