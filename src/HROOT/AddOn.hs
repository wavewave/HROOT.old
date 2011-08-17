{-# LANGUAGE TypeFamilies, GADTs, ExistentialQuantification, EmptyDataDecls #-}

module HROOT.AddOn where

--import Foreign.C            
import Foreign.ForeignPtr
--import Foreign.Marshal.Array


import HROOT.Class.Interface
import HROOT.Class.Implementation ()

data BottomType

class GADTTypeable a where
  data GADTType a :: * -> *
  data EGADTType a :: *

instance GADTTypeable TObject where
  data GADTType TObject a where 
    GADTTObjectTObject :: TObject -> GADTType TObject TObject
    GADTTObjectTH1F    :: TH1F -> GADTType TObject TH1F
    GADTTObjectBottom  :: GADTType TObject BottomType
  data EGADTType TObject = forall a. EGADTTObject (GADTType TObject a)


castTObject :: Exist TObject -> IO (EGADTType TObject)
castTObject eobj = do 
  let obj = TObject (get_fptr eobj)
  etclass <- isA obj  
  cname <- case etclass of ETClass tclass -> getName tclass
  case cname of 
    "TObject" -> case obj of 
        TObject fptr -> let obj' = TObject (castForeignPtr fptr :: ForeignPtr RawTObject)
                        in  return . EGADTTObject . GADTTObjectTObject $ obj'
    "TH1F"    -> case obj of
        TObject fptr -> let obj' = TH1F (castForeignPtr fptr :: ForeignPtr RawTH1F)
                        in  return . EGADTTObject . GADTTObjectTH1F $ obj'
    _         -> return . EGADTTObject $ GADTTObjectBottom



