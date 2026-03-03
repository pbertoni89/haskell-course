-- Define a function that takes a value and multiplies it by 3.
mul3 :: Int -> Int
mul3 x = x * 3

{-
Parse error: module header, import declaration
    or top-level declaration expected.
mul3 3
-}

-- build me with ghc git/Homework/Homework01/Homework01.hs
main :: IO ()
main = print (mul3 3)
