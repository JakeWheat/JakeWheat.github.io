
Couple of tweaks to the svg thing. More stuff can go in here when
needed.

1. change the title in the svg to 'projects plan' instead of ? '%3'

2. change the html tag for the svg from img to object so it works
properly (the links)


> import Data.List
> import Data.List.Split
> import System.Directory
> import Control.Monad

> main :: IO ()
> main = do
>     i <- readFile "index.html"
>     when (not (imgTagFind `isInfixOf` i)) $ error "couldn't find svg img tag in index.html"
>     writeFile "index.html.new" $ replace imgTagFind imgTagReplace i
>     renameFile "index.html.new" "index.html"

>     s <- readFile "projects_diagram.svg"
>     when (not (svgTitleFind `isInfixOf` s)) $ error "couldn't find title tag in projects_diagram.svg"
>     writeFile "projects_diagram.svg.new" $ replace svgTitleFind svgTitleReplace s
>     renameFile "projects_diagram.svg.new" "projects_diagram.svg"

> replace :: String -> String -> String -> String
> replace old new = intercalate new . splitOn old


> imgTagFind :: String
> imgTagFind = "<img src=\"projects_diagram.svg\" alt=\"projects diagram\">"

> imgTagReplace :: String
> imgTagReplace = "<object type=\"image/svg+xml\" data=\"projects_diagram.svg\"></object>"

> svgTitleFind :: String
> svgTitleFind = "<title>%3</title>"

> svgTitleReplace :: String
> svgTitleReplace = "<title>project plan</title>"
