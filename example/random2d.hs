module Main where

import Control.Monad

import Data.Random 
import Data.Random.Distribution.Normal

import HROOT.Type
import HROOT.Class 
import HROOT.AddOn

main :: IO () 
main = do 
  tcanvas <- newTCanvas "Test" "Test" 640 480
  h2 <- newTH2F "test" "test" 100 (-5.0) 5.0 100 (-5.0) 5.0 

  let dist1 = Normal (0 :: Double) (2 :: Double)
      dist2 = Normal (0 :: Double) (2 :: Double)

  let go n | n < 0 = return () 
           | otherwise = do 
               histfill dist1 dist2 h2
               go (n-1) 

  go 1000000
  draw h2 "lego"
  saveAs tcanvas "random2d.pdf" ""
  saveAs tcanvas "random2d.jpg" "" 
  saveAs tcanvas "random2d.png" ""



histfill :: Normal Double -> Normal Double-> TH2F ->  IO () 
histfill dist1 dist2 hist = do 
  x <- sample dist1
  y <- sample dist2
  fill2 hist x y 
  return () 
