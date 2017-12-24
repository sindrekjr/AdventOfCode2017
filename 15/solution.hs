import Data.Bits

nextA, nextB :: Int -> Int
nextA x = mod (x * 16807) 2147483647
nextB x = mod (x * 48271) 2147483647
startA = 883
startB = 879

part1 = length . filter id $ take 40000000 $ zipWith (==) (map (.&. 0xffff) $ iterate nextA startA) (map (.&. 0xffff) $ iterate nextB startB) --judge startA startB 0 40000000

{-
judge :: Int -> Int -> Int -> Int -> Int
judge a b count i
  | i == 0                   = count
  | otherwise                = judge nA nB nC (i - 1) where
    nA = nextA a
    nB = nextB b
    nC = if (num2bin nA == num2bin nB) then count + 1 else count-}

num2bin :: Int -> [Int]
num2bin n
  | n >= 0     =  reverse $ take 16 $ n2b n ++ [0,0..]
  | otherwise  =  error "num2bin: negative number"
  where n2b 0  =  []
        n2b n  =  n `mod` 2 : n2b (n `div` 2)
