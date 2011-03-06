module Main where

import HROOT.Type
import HROOT.Class
import HROOT.AddOn

main = do 
  tcanvas <- newTCanvas "test" "test" 640 480
--  tf1 <- newTF1 "test" "x+2" 10 20
  saveAs tcanvas "test.pdf" "" 
  putStrLn "test"
          