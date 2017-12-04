
readInt :: String -> Int
readInt = read

digits :: Int -> [Int]
digits = map (read . (:[])) . show

main = do
      rows <- return . map digits . map readInt . words =<< readFile "input"
      print (sum [ maximum(x) - minimum(x) | x <- rows ])
