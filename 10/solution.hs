-- 19591
import Data.List.Split

prsInt :: String -> Int
prsInt = read

knit list input i skip
  | length input == 0 = list
  | length list < i   = knit list input (i - length list) skip -- i might be logically free to cycle, making this line redundant
--  | length list > 256 = list
  | otherwise         = knit (start ++ middle ++ end) (drop 1 input) (i + skip + step) (skip + 1) where
      step = head input
      rev = reverse (take step (drop i (cycle list)))
      rnd = (i + step) - length list
      start = if rnd > 0 then drop (length rev - rnd) rev else take i list
      middle = if rnd > 0 then take (i - rnd) (drop rnd list) else take step (drop i list)
      end = if rnd > 0 then take (length list - i) (drop i list) else []
      --nl = list ++ rev
      --off = length nl - length list

part1 = do
  input <- return . map prsInt . splitOn "," =<< readFile "input"
  let list = knit [0..255] input 0 0
  return (length list)
  --return (list !! 0 * list !! 1)
