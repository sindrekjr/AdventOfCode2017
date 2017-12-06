import Data.List
import Data.Maybe

prsInt :: String -> Int
prsInt = read

cnt val ln start i
  | i == start  = (val `div` ln)
  | i > start   = ((val - (i - start)) `div` ln) + 1
  | otherwise   = ((val - ((ln + 1) - start)) `div` ln) + 1

redist :: [Int] -> [Int]
redist xs =
  [ if x == i
      then 0 + (cnt m (length xs) i x)
      else (xs !! x) + (cnt m (length xs) i x)
    | x <- [0..length xs - 1],
    let m = maximum xs,
    let i = fromJust (elemIndex m xs)
  ]

main = do
  inp <- return . map prsInt . words =<< readFile "input"
  return [ x | x <- redist (inp) ]
  --return (redist (redist inp))
