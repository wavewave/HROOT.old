module Main where

import HROOT.Type
import HROOT.Class
import HROOT.AddOn

main = do 
  tapp <- newTApplication "test" [0] ["test"] 
  tcanvas <- newTCanvas "test" "test" 640 480
  h1 <- newTH1F "test" "test" 100 1 10
  h2 <- newTH1F "test" "test" 100 1 10 
  
  fill1 h1 5 
  fill1 h2 6
  
  add h1 h2 1.0
  
  draw h1 "" 
  
  run tapp 
--  saveAs tcanvas "test.pdf" "" 
--  putStrLn "test"
          