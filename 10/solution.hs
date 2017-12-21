import Data.List.Split
import Data.Char (ord)
import Data.Maybe
import Data.Bits (xor)
import Data.Bool
import Data.List
import Numeric

knit :: [Int] -> [Int] -> Int -> Int -> [Int]
knit list input i skip
  | length input == 0 = list
  | otherwise         = knit nl (tail input) (cycle [0..length list - 1] !! (i + skip + len)) (skip + 1) where
      len = head input
      rev = reverse (take len (drop i (cycle list)))
      rnd = if (i + len) - (length list) < 0 then 0 else (i + len) - (length list)
      nl = take rnd (drop (len - rnd) rev) ++ take (i - rnd) (drop rnd list) ++ take (len - rnd) rev ++ drop (i + len) list

part1 = do
  input <- return . map (read :: String -> Int) . splitOn "," =<< readFile "input"
  let result = knit [0..255] input 0 0
  return $ result !! 0 * result !! 1

part2 = do
  input <- return . map ord =<< readFile "input"
  let ascList = input ++ [17, 31, 73, 47, 23]
  let sparseHash = knit [0..255] (take (64 * length ascList) (cycle ascList)) 0 0
  let denseHash = map (foldl' xor 0) (unfoldr (bool (Just . splitAt 16) (const Nothing) =<< null) sparseHash)
  print $ concatMap (flip showHex "") denseHash
