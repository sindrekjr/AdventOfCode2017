import Data.List
import Data.Maybe

spin :: [Int] -> Int -> Int -> [Int]
spin buffer steps count
  | head buffer >= count = buffer
  | otherwise            = spin ((succ $ head buffer):(take (length buffer) (drop (steps + 1) (cycle buffer)))) steps count

part1 = spin [0] 314 2017 !! 1
part2 = spun !! (succ $ fromJust $ elemIndex 0 spun) where
  spun = spin [0] 314 50000000
