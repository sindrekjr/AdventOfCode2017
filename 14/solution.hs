import Control.Parallel.Strategies (parMap, rpar)
import Data.Char (ord)
import Data.Bits
import Data.Bool
import Data.List

knit :: [Int] -> [Int] -> Int -> Int -> [Int]
knit list input i skip
  | length input == 0 = list
  | otherwise         = knit nl (tail input) (cycle [0..length list - 1] !! (i + skip + len)) (skip + 1) where
      len = head input
      rev = reverse (take len (drop i (cycle list)))
      rnd = if (i + len) - (length list) < 0 then 0 else (i + len) - (length list)
      nl = take rnd (drop (len - rnd) rev) ++ take (i - rnd) (drop rnd list) ++ take (len - rnd) rev ++ drop (i + len) list

ascList inp = inp ++ [17, 31, 73, 47, 23]
sparseHash inp = knit [0..255] (take (64 * length asc) (cycle asc)) 0 0 where asc = ascList inp
denseHash inp = map (foldl' xor 0) (unfoldr (bool (Just . splitAt 16) (const Nothing) =<< null) (sparseHash inp))

part1 = do
  input <- readFile "input"
  let grid = [ map ord $ input ++ "-" ++ show i | i <- [0..127] ]
  print $ sum . map popCount . concat $ parMap rpar denseHash grid
