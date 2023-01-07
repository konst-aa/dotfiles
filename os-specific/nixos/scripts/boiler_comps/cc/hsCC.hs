import qualified Data.Set as Set
import System.IO

-- https://stackoverflow.com/a/4981265
-- string concat will go into its own stub bc there's wayy more processing needed
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =
  case dropWhile p s of
    "" -> []
    s' -> w : wordsWhen p s''
      where (w, s'') = break p s'

-- generically useful
type Coord = (Int, Int)

addTwo :: Coord -> Coord -> Coord
addTwo (a, b) (c, d) = (a + c, b + d)

conv :: Bool -> Int
conv True = 1
conv False = 0

takeLast :: Int -> [a] -> [a]
takeLast n l = drop (length l - n) l

dropLast :: Int -> [a] -> [a]
dropLast n l = take (length l - n) l

-- stub over
--
main :: IO ()
main = do
  contents <- readFile "input.txt"
  print contents
