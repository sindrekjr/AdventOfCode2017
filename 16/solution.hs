import Data.List.Split

part1 = do
  input <- return . splitOn "," =<< readFile "input"
  return $ dance ['a'..'p'] input

part2 = do
  input <- return . splitOn "," =<< readFile "input"
  let loop = reverse $ findLoop [['a'..'p']] input
  return $ loop !! (mod 1000000000 (length loop - 1))

findLoop prgs moves
  | elem (head prgs) (tail prgs) = prgs
  | otherwise                    = findLoop ([dance (head prgs) moves] ++ prgs) moves

dance :: [Char] -> [String] -> [Char]
dance prgs moves
  | length moves == 0, otherwise = prgs
  | head moves !! 0 == 's'       = dance (s prgs (tail $ head moves)) (tail moves)
  | head moves !! 0 == 'x'       = dance (x prgs (tail $ head moves)) (tail moves)
  | head moves !! 0 == 'p'       = dance (p prgs (tail $ head moves)) (tail moves)

s, x, p :: [Char] -> String -> [Char]
s prgs move = take (length prgs) (drop (length prgs - read move) (cycle prgs))
x prgs move = [ prgs !! y | x <- [0..length prgs - 1], let a = (read $ splitOn "/" move !! 0 :: Int), let b = (read $ splitOn "/" move !! 1 :: Int), let y | x == a = b | x == b = a | otherwise = x ]
p prgs move = [ y | x <- prgs, let y | x == move !! 0 = move !! 2 | x == move !! 2 = move !! 0 | otherwise = x ]
