main = do
  input <- return . (read :: String -> Int) =<< readFile "input"
  return $ spin [0] input where
    spin buffer steps
      | length buffer >= 2018 = take 1 $ tail buffer
      | otherwise             = spin ((succ $ head buffer):(take (length buffer) (drop (steps + 1) (cycle buffer)))) steps
