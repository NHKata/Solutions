import Solution2

main :: IO ()
main = if tests
        then putStrLn "All tests passed"
        else putStrLn "Tests failed"

tests :: Bool
tests = and
  [ solve [1,2,3,4,4,3,2,1] == 4.0
  , solve [1,1,2]           == 2.0
  , solve [1,2,3]           == 2.0
  , solve [1,2,1]           == 1.5
  , solve [1,1,1000,1]      == 2.4995
  , solve [2,2,2,6]         == 3
  , solve [4,6,3,3,3,1]     == 2
  , solve [4,6,3,3,3,4]     == 2.5
  , solve []                == 0
  , solve [0,0,2]           == 2.5
  , solve [0,0,10]          == 2.5
  , solve [0,0,10,1]        == 2.55
  ]
