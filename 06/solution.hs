import Data.List
import Data.Maybe

prsInt :: String -> Int
prsInt = read

cnt val ln start x
  | x == start  = if val >= ln then 1 else 0
  | x > start   = if val >= (x - start) then 1 else 0
  | otherwise   = if val >= ((ln + x) - start) then 1 else 0

redist :: [Int] -> [Int]
redist xs =
  [ if x == start
      then 0 + (cnt m ln start x)
      else (xs !! x) + (cnt m ln start x)
    | x <- [0..length xs - 1],
    let ln = length xs,
    let m = maximum xs,
    let start = fromJust (elemIndex m xs)
  ]

next :: [[Int]] -> Int -> [[Int]]
next list cycles
  | (head list) `elem` (drop 1 list)  = list
  | otherwise                         = next ([redist (head list)] ++ list) (cycles + 1)

part1 = do
  input <- return . map prsInt . words =<< readFile "input"
  return (length (next [input] 0) - 1)

part2 = do
  input <- return . map prsInt . words =<< readFile "input"
  let list = next [input] 0
  return (fromJust (elemIndex (head list) (drop 1 list)) + 1)
