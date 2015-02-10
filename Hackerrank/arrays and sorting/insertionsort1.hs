--this is going to be REALLY dumb
doublify [] _ = []
doublify (x:xs) y = if x == y then x:x:xs
                    else x: (doublify xs y)

ins xs y = let zs = reverse xs in
           map (\x -> if x > y then doublify xs x else []) zs
