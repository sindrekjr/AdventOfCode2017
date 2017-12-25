import Data.Bits

nextA, nextB :: Int -> Int
nextA x = mod (x * 16807) 2147483647
nextB x = mod (x * 48271) 2147483647
startA = 883
startB = 879

part1 = length . filter id $ take 40000000 $ zipWith (==) (map (.&. 0xffff) $ iterate nextA startA) (map (.&. 0xffff) $ iterate nextB startB)
part2 = length . filter id $ take 5000000 $ zipWith (==) (map (.&. 0xffff) $ filter ((==0) . (`mod` 4)) $ iterate nextA startA) (map (.&. 0xffff) $ filter ((==0) . (`mod` 8)) $ iterate nextB startB)
