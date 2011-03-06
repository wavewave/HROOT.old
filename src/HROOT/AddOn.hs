{-# LANGUAGE ForeignFunctionInterface, TypeFamilies, MultiParamTypeClasses, 
             FlexibleInstances, TypeSynonymInstances, UndecidableInstances, 
             EmptyDataDecls #-}

module HROOT.AddOn where

import Foreign.C            
import Foreign.Ptr
import Foreign.ForeignPtr

import System.IO.Unsafe

import HROOT.Type
import HROOT.Function
import HROOT.Class
import HROOT.AddOnFunction

type HistName  = String
type HistTitle = String  

{-
newTF1 :: String -> String -> Double -> Double -> IO TF1
newTF1 name formula xmin xmax = do 
  c_name <- newCString name 
  c_formula <- newCString formula
  
  let c_xmin = realToFrac xmin
      c_xmax = realToFrac xmax 
      
  rptr <- c_tf1_new c_name c_formula c_xmin c_xmax 
  fptr <- newForeignPtr_ rptr 
  return $ TF1 fptr 


newTCanvas :: String -> String -> Int -> Int -> IO TCanvas 
newTCanvas name title ww wh = do 
  c_name <- newCString name 
  c_title <- newCString title 
  
  let c_ww   = fromIntegral ww
      c_wh   = fromIntegral wh
                
  rptr <- c_tcanvas_new c_name c_title c_ww c_wh
  fptr <- newForeignPtr_ rptr
  return $ TCanvas fptr

newTH1F :: HistName -> HistTitle -> Int -> Double -> Double -> IO TH1F
newTH1F name title chan lowval highval = do 
  c_name <- newCString name 
  c_title <- newCString title 
  
  let c_chan    = fromIntegral chan
      c_lowval  = realToFrac lowval
      c_highval = realToFrac highval 

                
  rptr <- c_th1f_new c_name c_title c_chan c_lowval c_highval
  fptr <- newForeignPtr_ rptr
  return $ TH1F fptr

-}