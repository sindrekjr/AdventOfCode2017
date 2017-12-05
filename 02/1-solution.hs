readInt :: [String] -> [[Int]]
readInt = map (map read . words)

main = do
      rows <- return . readInt . lines =<< readFile "input"
      print (sum [ maximum(x) - minimum(x) | x <- rows ])
