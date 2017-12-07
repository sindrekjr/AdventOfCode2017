import Data.List
import Data.Maybe

prsInt :: String -> Int
prsInt = read

fRep :: Int -> (a -> a) -> a -> a
fRep n func x
  | n == 0    = x
  | otherwise = func (fRep (n-1) func x)

cnt val ln start i
  | i == start = (val `div` ln)
  | i > start  = ((val - (i - start)) `div` ln) + 1
  | otherwise  = ((val - ((ln + 1) - start)) `div` ln) + 1

redist xs =
  [ if x == i
      then 0 + (cnt m (length xs) i x)
      else (xs !! x) + (cnt m (length xs) i x)
    | x <- [0..length xs - 1],
    let m = maximum xs,
    let i = fromJust (elemIndex m xs)
  ]

main = do
  input <- return . map prsInt . words =<< readFile "input"
  let list = nub [ if x == 0 then y else fRep x redist y | x <- [0..300], let y = input ]
  return (length list)
