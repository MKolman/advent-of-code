import Data.Map (Map)
import qualified Data.Map as Map

type Point = (Integer, Integer)

main :: IO ()
main = do
    allStdin <- getContents
    let allLines = lines allStdin
    let parsedLines = map parseLine allLines
    let drawnLines1 = map drawLine parsedLines
    print(countMulti (concat drawnLines1))
    let drawnLines2 = map drawLine2 parsedLines
    print(countMulti (concat drawnLines2))

parseLine :: String -> (Point, Point)
parseLine line = dropMid (words [if c == ',' then ' ' else c|c <- line])

dropMid :: [String] -> (Point, Point)
dropMid v = ((read (v!!0), read (v!!1)), (read (v!!3), read (v!!4)))

drawLine :: (Point, Point) -> [Point]
drawLine ((x, y), (a, b)) | b < y  = drawLine ((a, b), (x, y))
                       | b == y && a < x = drawLine ((a, b), (x, y))
                       | a == x = [(a, i) | i <- [y..b]]
                       | b == y = [(i, b) | i <- [x..a]]
                       | otherwise = [] 

drawLine2 :: (Point, Point) -> [Point]
drawLine2 ((x, y), (a, b)) | b < y  = drawLine2 ((a, b), (x, y))
                       | b == y && a < x = drawLine2 ((a, b), (x, y))
                       | a == x = [(a, i) | i <- [y..b]]
                       | b == y = [(i, b) | i <- [x..a]]
                       | x < a = [(x+i, y+i) | i <- [0..(a-x)]]
                       | x > a = [(x-i, y+i) | i <- [0..(x-a)]]
                       | otherwise = [] 

frequency :: [Point] -> [(Point, Int)]
frequency xs = Map.toList (Map.fromListWith (+) [(x, 1) | x <- xs])

countMulti :: [Point] -> Int
countMulti points = length (filter (\(_, n) -> n > 1) (frequency points))

