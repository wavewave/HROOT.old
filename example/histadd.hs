module Main where

import Data.Random
import Data.Random.Distribution.Normal

import HROOT.Type
import HROOT.Class
import HROOT.AddOn

main = do 
  tcanvas <- newTCanvas "test" "test" 640 480
  
  h1 <- newTH1F "test" "test" 100 (-10.0) 10.0  
  h2 <- newTH1F "test" "test" 100 (-10.0) 10.0 
  
  let dist1 = Normal (0 :: Double) (2 :: Double) 
      dist2 = Normal (3 :: Double) (1 :: Double)
  let go n | n < 0 = return () 
           | otherwise = do 
               histfill dist1 h1 
               histfill dist2 h2 
               go (n-1)
  go 1000000 
 
  add h1 h2 1.0 
 
  draw h1 ""   

  saveAs tcanvas "histadd.pdf" "" 
  saveAs tcanvas "histadd.jpg" ""
  saveAs tcanvas "histadd.png" ""

  delete h1
  delete h2
  delete tcanvas

  return () 

          
histfill :: Normal Double -> TH1F -> IO () 
histfill dist hist = do 
  x <- sample dist 
  fill1 hist x 
  return () 

