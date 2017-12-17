import Data.List.Split

main = do
  input <- return . splitOn "," =<< readFile "input"
  return (dance (['a'..'p']) input)

dance :: [Char] -> [String] -> [Char]
dance programs moves
  | length moves == 0, otherwise  = programs
  | moves !! 0 !! 0 == 's'        = dance (s programs (moves !! 0)) (tail moves)
  | moves !! 0 !! 0 == 'x'        = dance (x programs (moves !! 0)) (tail moves)
  | moves !! 0 !! 0 == 'p'        = dance (p programs (moves !! 0)) (tail moves)

s, x, p :: [Char] -> String -> [Char]
s p m = take (length p) (drop ((length p) - read (drop 1 m)) (cycle p))
x p m = [ p !! y | x <- [0..length p - 1], let a = read ((splitOn "/" (drop 1 m)) !! 0) :: Int, let b = read ((splitOn "/" (drop 1 m)) !! 1) :: Int, let y | x == a = b | x == b = a | otherwise = x ]
p p m = [ y | x <- p, let y | x == m !! 1 = m !! 3 | x == m !! 3 = m !! 1 | otherwise = x ]
