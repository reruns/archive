import Control.Monad

moves [x,y,z] = tops ++ mids ++ bots where
                tops = if x == 0 then [] else zipWith (:) [0..(x-1)] (repeat [y,z])
                mids = [[a,b,z] | b <- [0..(y-1)], a <- [min x b]]
                bots = [[a,b,c] | c <- [1..(z-1)], a <- [min x c], b <- [min y c]]

--this produces the correct answer, but needs to be memoized
game [0,0,1] = False
game [x,y,z] = not $ all game $ moves [x,y,z]

g [x,y,z] = if game [z,y,x] then "WIN" else "LOSE"

main = do
  t <- readLn :: IO Int
  replicateM_ t $ do
    str <- getLine
    let [x,y,z] = map read $ words str
    putStrLn $ g [x,y,z]
