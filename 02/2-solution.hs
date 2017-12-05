readInt :: [String] -> [[Int]]
readInt = map (map read . words)

evenbetter :: [Int] -> Int
evenbetter xs = head [ x `div` y | x <- xs, y <- xs, x `mod` y == 0, x /= y ]

main = do
  rows <- return . readInt . lines =<< readFile "input"
  print $ sum $ map evenbetter rows
