import qualified Data.Set as Set
import System.IO

-- https://stackoverflow.com/a/4981265
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =
  case dropWhile p s of
    "" -> []
    s' -> w : wordsWhen p s''
      where
        (w, s'') = break p s'

conv :: Bool -> Int
conv True = 1
conv False = 0

main :: IO ()
main = do
  contents <- readFile "input.txt"
