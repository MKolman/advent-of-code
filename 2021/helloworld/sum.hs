main :: IO ()
main = do
    line <- getLine
    let a = (read (takeWhile (/= ' ') line) :: Int)
    let b = (read (drop 1 (dropWhile (/= ' ') line)) :: Int)
    putStrLn (show (a+b)) 
