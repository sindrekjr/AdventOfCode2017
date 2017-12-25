main = print $ length $ filter (not . prime) [b, b + 17..b + 17000] where
  b = (79 * 100) - (-100000)
  prime x = not $ any divisible $ takeWhile notTooBig [2..] where
    divisible y = mod x y == 0
    notTooBig y = y * y <= x
