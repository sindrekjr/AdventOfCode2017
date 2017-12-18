import Data.List
import Data.Maybe

prsInt :: String -> Int
prsInt = read

redist :: [Int] -> [Int]
redist xs =
  [ if x == start then 0 + inc else if rest >= (mod (x - start) ln) then (xs !! x) + inc + 1 else (xs !! x) + inc |
    x <- [0..length xs - 1],
    let ln = length xs,
    let m = maximum xs,
    let inc = div m ln,
    let rest = mod m ln,
    let start = fromJust (elemIndex m xs)
  ]

next :: [[Int]] -> Int -> [[Int]]
next list cycles
  | elem (head list) (tail list) = list
  | otherwise                    = next ([redist (head list)] ++ list) (cycles + 1)

part1 = do
  input <- return . map prsInt . words =<< readFile "input"
  return $ length (next [input] 0) - 1

part2 = do
  input <- return . map prsInt . words =<< readFile "input"
  let list = next [input] 0
  return $ fromJust (elemIndex (head list) (drop 1 list)) + 1
