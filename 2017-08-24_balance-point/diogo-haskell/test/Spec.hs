import Lib

main :: IO ()
main = if tests
        then putStrLn "All tests passed"
        else putStrLn "Tests failed"

tests :: Bool
tests = and
  [ solve [1,2,3,4,4,3,2,1] == Just 4.0
  , solve [1,1,2]           == Just 2.0
  , solve [1,2,3]           == Just 2.0
  , solve [1,2,1]           == Just 1.5
  , solve [1,1,1000,1]      == Just 2.4995
  , solve [2,2,2,6]         == Just 3
  , solve [4,6,3,3,3,1]     == Just 2
  , solve [4,6,3,3,3,4]     == Just 2.5
  ]
