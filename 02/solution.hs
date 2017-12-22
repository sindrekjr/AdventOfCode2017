wholeNums :: [Int] -> Int
wholeNums xs = head [ x `div` y | x <- xs, y <- xs, x `mod` y == 0, x /= y ]

main = do
  rows <- return . (map (map read . words) :: [String] -> [[Int]]) . lines =<< readFile "input"
  print $ [(sum [ maximum(x) - minimum(x) | x <- rows ])] ++ [(sum $ map wholeNums rows)]
