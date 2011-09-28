{-# LANGUAGE TypeFamilies, GADTs, ExistentialQuantification, EmptyDataDecls, ScopedTypeVariables #-}

module HROOT.AddOn where

{-
import Foreign.ForeignPtr
import HROOT.Class.Interface

upcastTH2 :: (FPtr a, ITH2 a) => a -> TH2 
upcastTH2 h = let fh = get_fptr h
                  fh2 :: ForeignPtr RawTH2 =  castForeignPtr fh 
              in cast_fptr_to_obj fh2  
-}
