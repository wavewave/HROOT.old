{-# LANGUAGE ForeignFunctionInterface, TypeFamilies, MultiParamTypeClasses, 
             FlexibleInstances, TypeSynonymInstances, UndecidableInstances, 
             EmptyDataDecls #-}

module HROOT.AddOnFunction where

import Foreign.C            
import Foreign.Ptr
import Foreign.ForeignPtr

import System.IO.Unsafe

import HROOT.Type
import HROOT.Function
import HROOT.Class

#include "addon.h"
 
{-
foreign import ccall "addon.h TF1_New" c_tf1_new
  :: CString -> CString -> CDouble -> CDouble -> IO (Ptr RawTF1)

foreign import ccall "makehist.h TCanvas_New" c_tcanvas_new
  :: CString -> CString -> CInt -> CInt -> IO (Ptr RawTCanvas)

foreign import ccall "makehist.h TH1F_New" c_th1f_new
  :: CString -> CString -> CInt -> CDouble -> CDouble -> IO (Ptr RawTH1F)
-}