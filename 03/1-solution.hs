diff x y = if x > y then x - y else y - x

sqroot :: Int -> Int
sqroot n = aux n
  where
    aux x
      | x*x > n = aux (x - 1)
      | otherwise = x

main = do
  input <- readFile "input"
  let number = read input :: Int
  let root = sqroot number
  let oddsquares = [ x | x <- map (^2) [2..root + 1], odd x ]
  if (last oddsquares - root) < number
    then
      print ((length oddsquares) + diff (last oddsquares - (root `div` 2)) number )
    else
      print "fail"
