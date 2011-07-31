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
  h1 <- newTH1F "test" "test" 100 (-5.0) 5.0 

  let dist = (Normal (0 :: Double) (2 :: Double)) 

  let go n | n < 0 = return () 
           | otherwise = do 
               histfill dist h1
               go (n-1) 

  go 1000000
  draw h1 ""
  saveAs tcanvas "random1d.pdf" ""
  saveAs tcanvas "random1d.jpg" "" 


histfill :: Normal Double -> TH1F ->  IO () 
histfill dist hist = do 
  x <- sample dist 
  fill1 hist x
  return () 
