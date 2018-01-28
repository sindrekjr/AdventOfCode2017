import Data.List.Split
import Data.Char (ord)
import Data.Maybe
import Data.Bits (xor)
import Data.Bool
import Data.List
import Numeric
import Text.Printf

knit :: [Int] -> [Int] -> Int -> Int -> [Int]
knit list input i skip
  | length input == 0 = list
  | otherwise         = knit nl (tail input) (cycle [0..length list - 1] !! (i + skip + len)) (skip + 1) where
      len = head input
      rev = reverse (take len (drop i (cycle list)))
      rnd = if (i + len) - (length list) < 0 then 0 else (i + len) - (length list)
      nl = take rnd (drop (len - rnd) rev) ++ take (i - rnd) (drop rnd list) ++ take (len - rnd) rev ++ drop (i + len) list

ascList, sparseHash, denseHash :: [Int] -> [Int]
ascList inp = inp ++ [17, 31, 73, 47, 23]
sparseHash inp = knit [0..255] (take (64 * length asc) (cycle asc)) 0 0 where asc = ascList inp
denseHash inp = map (foldl' xor 0) (unfoldr (bool (Just . splitAt 16) (const Nothing) =<< null) (sparseHash inp))

part1 = do
  input <- return . map (read :: String -> Int) . splitOn "," =<< readFile "input"
  let result = knit [0..255] input 0 0
  return $ result !! 0 * result !! 1

part2 :: IO String
part2 = do
  input <- return . map ord =<< readFile "input"
  return $ concatMap (flip showHex "") $ denseHash input
