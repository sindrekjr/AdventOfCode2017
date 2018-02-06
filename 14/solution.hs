import Control.Parallel.Strategies (parMap, rpar)
import Data.Bits (popCount, xor)
import Data.Bool (bool)
import Data.Char (digitToInt, ord)
import Data.List
import Data.Maybe (fromJust)
import Numeric
import Text.Printf (printf)

hexToBin :: Char -> Maybe String
hexToBin c
  = case readHex [c] of
      (x,_):_ -> Just $ printf "%04b" (x::Int)
      _       -> Nothing

flatten :: [[a]] -> [a]
flatten xs = (\z n -> foldr (\x y -> foldr z y x) n xs) (:) []

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

grid :: String -> [[Int]]
grid inp = [ map ord $ inp ++ "-" ++ show i | i <- [0..127] ]

dualInc :: (Int,Int) -> Int -> (Int,Int)
dualInc (x,y) yLen = (nx,ny) where
  ny = if succ y == yLen then 0 else succ y
  nx = if y > ny then succ x else x

findRegions :: [[Int]] -> (Int,Int) -> [[(Int,Int)]] -> [[(Int,Int)]]
findRegions inp (x,y) regions
  | (x,y) == (length inp - 1, (length $ inp !! x) - 1) = regions
  | elem (x,y) (flatten regions) = findRegions inp (dualInc (x,y) (length $ head inp)) regions
  | inp !! x !! y == 0           = findRegions inp (dualInc (x,y) (length $ head inp)) regions
  | otherwise                    = findRegions inp (dualInc (x,y) (length $ head inp)) (regions ++ [ region inp [] [(x,y)] ])

region :: [[Int]] -> [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
region inp result xs
  | xs == []  = nub result
  | otherwise = region inp nresult nxs where
    nresult = head xs:result
    (x,y) = head nresult
    nxs = [ (nx,ny) | (nx,ny) <- [(x+1,y),(x-1,y),(x,y+1),(x,y-1)], not $ elem (nx,ny) nresult, nx <= 127, nx >= 0, ny <= 127, ny >= 0, inp !! nx !! ny == 1 ] ++ tail xs

part1 = do
  input <- readFile "input"
  print $ sum . map popCount . concat $ parMap rpar denseHash $ grid input

part2 = do
  input <- readFile "input"
  let hex = map (concatMap (printf "%02x")) . parMap rpar denseHash $ grid input
  print $ length $ findRegions (map (map digitToInt . concatMap fromJust . map hexToBin) hex) (0,0) []
