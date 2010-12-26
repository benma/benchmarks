{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
import Prelude hiding (putStr)
import Data.ByteString.Char8 (ByteString, putStr, pack)
import Numeric (showInt)
import "wai" Network.Wai
import Network.Wai.Enumerator
import Network.Wai.Handler.CGI
import qualified Data.ByteString.Lazy as L

main = run app

app _ = return $ Response status200 [("Content-Type", "text/html")]
               $ ResponseLBS content

content :: L.ByteString
content = L.fromChunks
      $ "<table>"
      : foldr ($) ["</table>"] (replicate 1000 makeRow)

makeRow :: [ByteString] -> [ByteString]
makeRow rest = foldr (:) rest $ map makeCol [1..50]

makeCol 1 = "<tr><td>1</td>"
makeCol 50 = "<td>50</td></tr>"
makeCol i = pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"