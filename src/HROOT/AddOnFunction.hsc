{-# LANGUAGE ForeignFunctionInterface #-}

module HROOT.AddOnFunction where

foreign import ccall "addon.h TF1_New" c_tf1_new
  :: CString -> CString -> CDouble -> CDouble -> IO (Ptr RawTF1)
