import Data.List (sort, nub, tails, uncons)

unique :: (Eq a) => [a] -> Bool
unique = not . any (maybe False (uncurry elem) . uncons) . tails

main = do
      phrases <- return . nub . filter (unique . map sort) . map words . lines =<< readFile "input"
      print (length phrases)
