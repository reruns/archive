--Step 1. Find the diameter, d, of the graph.
  --Find one endpoint by doing a BFS on any node.
  --Find the second endpoint by doing a BFS on that one.
--Step 2. Find the eccentricity of the starting city,v.
--  The answer is (k-1)d + e(v)

import Control.Monad
import qualified Data.Vector as V
import Data.List
import Data.Ord
import Data.Tuple

--This works but is too slow/memory intensive. Make it better!
eccentricity g v = search (g V.! v) ks 0 where
    ks = (V.fromList (replicate (V.length g) True)) V.// (zip (v:(g V.! v)) (repeat False))
    search vs seen n = if vs==[] then n else search cs (seen V.// (zip cs (repeat False))) (n+1) where
        cs = filter (seen V.!) (concatMap (g V.!) vs)

diameter g = eccentricity g (search (g V.! 1) ks) where
    ks = (V.fromList (replicate (V.length g) True)) V.// (zip (1:(g V.! 1)) (repeat False))
    search vs seen = if cs==[] then head vs else search cs (seen V.// (zip cs (repeat False))) where
        cs = filter (seen V.!) (concatMap (g V.!) vs)

graphify es = (V.fromList (replicate (1+length t) [])) V.// t where
  t = map g $ groupBy (\x y -> (fst x) == (fst y)) $ sortBy (comparing fst) (es ++ (map swap es))
  g l = ((head.fst$unzip l), (snd$unzip l))

tuplify str = (a,b) where
  a = read (head$ words str)
  b = read (last$ words str)

main = do
  cstr <- getLine
  let [n,m] = map read $ words cstr
  pairs <- replicateM (n-1) getLine
  let es = map tuplify pairs
      g = graphify es
      d = diameter g
  replicateM_ m $ do
    vstr <- getLine
    let [v,k] = map read $ words vstr
    print $ (k-1)*d + (eccentricity g v)
