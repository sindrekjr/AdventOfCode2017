import Protolude (liftM2)
import Data.List
import Data.Maybe

main = do
  input <- return . (read :: String -> Int) =<< readFile "input"
  print $ last $ until ((>input) . last) work [1]

work list = list ++ [sum $ map (\n -> if n < length list then list !! n else 0) numbers] where
  (x,y) = spiral !! length list
  numbers = map (fromJust . flip elemIndex spiral) (liftM2 (,) [x-1..x+1] [y-1..y+1])

spiral = zip (step 0 0 1) (step 1 0 1)

step n from to
  | to > 0 = replicate n from ++ [from,from+1..to-1] ++ step (n+1) to (0-to)
  | to < 0 = replicate n from ++ [from,from-1..to+1] ++ step (n+1) to (1-to)
