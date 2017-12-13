import Data.List (sort, nub, tails, uncons)

unique :: (Eq a) => [a] -> Bool
unique = not . any (maybe False (uncurry elem) . uncons) . tails

part1 = do
  phrases <- return . nub . filter unique . map words . lines =<< readFile "input"
  print ("Part 1: " ++ (show (length phrases)))

part2 = do
  phrases <- return . nub . filter (unique . map sort) . map words . lines =<< readFile "input"
  return ("Part 2: " ++ (show (length phrases)))
