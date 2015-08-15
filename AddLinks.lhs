
Little hack to add links to the navigation bars

> import System.Environment

> main :: IO ()
> main = do
>     args <- getArgs
>     let pre = case args of
>                   [] -> ""
>                   [p] -> p ++ "/"
>     interact (addLinks pre)


> addLinks :: String -> String -> String
> addLinks _ [] = error "not found"
> addLinks p ('<':'/':'u':'l':'>':'\n':'<':'/':'d':'i':'v':'>':xs) =
>     "</ul>" ++ linkSection p ++ "\n</div>" ++ xs
> addLinks p (x:xs) = x : addLinks p xs

> linkSection :: String -> String
> linkSection p =
>   "<hr />\n\
>   \<ul class=\"sectlevel1\">\n\
>   \<div id=\"toctitle\">Links</div>\n\
>   \<li><a href=\"" ++ p ++ "index.html\">Index</a></li>\n\
>   \<li><a href='" ++ p ++ "hssqlppp/latest/index.html'>hssqlppp</li>\n\
>   \<li><a href='" ++ p ++ "simple-sql-parser/latest/index.html'>simple-sql-parser</li>\n\
>   \<li><a href='" ++ p ++ "sql-overview/index.html'>sql-overview</li>\n\
>   \<li><a href='" ++ p ++ "intro_to_parsing/index.html'>intro_to_parsing</li>\n\
>   \</ul>\n\
>   \<br />\n\
>   \<ul class=\"sectlevel1\">\n"
>   ++ (if null p then (
>   "<li><a href=\"http://jakewheat.github.io/\" class=\"bare\">Homepage</a></li>\n\
>   \<li><a href=\"https://github.com/JakeWheat/jakewheat.github.io\" class=\"bare\">Repository</a></li>\n\
>   \<li><a href=\"https://github.com/JakeWheat/jakewheat.github.io/issues\" class=\"bare\">Bug tracker</a></li>\n")
>      else "<li><a href=\"../index.html\" class=\"bare\">Parent project</a>\n")
>   ++
>   "</li><li>jakewheatmail@gmail.com</li>\n\
>   \</ul>\n"
