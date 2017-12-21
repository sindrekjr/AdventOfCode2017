import Data.List.Split

knit :: [Int] -> [Int] -> Int -> Int -> [Int]
knit list input i skip
  | length input == 0 = list
  | otherwise         = knit nl (drop 1 input) (cycle [0..length list - 1] !! (i + skip + len)) (skip + 1) where
      len = head input
      rev = reverse (take len (drop i (cycle list)))
      rnd = if (i + len) - (length list) < 0 then 0 else (i + len) - (length list)
      nl = take rnd (drop (len - rnd) rev) ++ take (i - rnd) (drop rnd list) ++ take (len - rnd) rev ++ drop (i + len) list

part1 = do
  input <- return . map (read :: String -> Int) . splitOn "," =<< readFile "input"
  let result = knit [0..255] input 0 0
  return $ result !! 0 * result !! 1
