module AddOn where

newTF1 :: String -> String -> Double -> Double -> IO TF1
newTF1 name formula xmin xmax = do 
  c_name <- newCString name 
  c_name <- newCString formula
  
  let c_xmin = realToFrac xmin
      c_xmax = realToFrac xmax 
      
  rptr <- c_tf1_new c_name c_formula c_xmin c_xmax 
  fptr <- newForeignPtr_ rptr 
  return $ TF1 fptr 
