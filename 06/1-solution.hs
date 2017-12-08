import Data.List
import Data.Maybe

prsInt :: String -> Int
prsInt = read

{-
fRep :: Int -> (a -> a) -> a -> a
fRep n func x
  | n == 0    = x
  | otherwise = func (fRep (n-1) func x)
-}

cnt val ln start i
  | i == start = (div val ln)
  | i > start  = (div (val - (i - start)) ln)
  | otherwise  = (div (val - ((ln + 1) - start)) ln) + 1

redist :: [Int] -> [[Int]]
redist xs =
  [[ if x == i
      then 0 + (cnt m (length xs) i x)
      else (xs !! x) + (cnt m (length xs) i x)
    | x <- [0..length xs - 1],
    let m = maximum xs,
    let i = fromJust (elemIndex m xs)
  ]]

next :: [[Int]] -> Int -> Int
next list cycles
  | (head list) `elem` (drop 1 list) = cycles
  | cycles > 5000 = cycles
  | otherwise = next (redist (head list) ++ list) (cycles + 1)

main = do
  input <- return . map prsInt . words =<< readFile "input"
  return (next [input] 0)
  --let list = nub [ fRep x redist y | x <- [0..1000], let y = input ]
  --return (length list)
  --let avgMax = div (sum [ maximum x | x <- list ]) (length list)
  --return (length list * avgMax)
