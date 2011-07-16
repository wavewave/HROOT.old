module Config where

import Control.Monad.Identity

import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.PackageDescription
import Distribution.Simple.LocalBuildInfo

import System.Exit
import System.Process

import Text.Parsec

config :: LocalBuildInfo -> IO HookedBuildInfo 
config bInfo = do 
  (excode, out, err) <- readProcessWithExitCode "root-config" ["--glibs"] ""  
  liboptset <- case excode of 
                 ExitSuccess -> do  
                   putStrLn $ show $ words out
                   putStrLn $ show $ libraryOptions (words out)
                   putStrLn $ show $ mkLibraryOptionSet . words $ out
                   return . mkLibraryOptionSet . words $ out
                 _ -> error "root-config failure" 
  (excode2,out2,err2) <- readProcessWithExitCode "root-config" ["--incdir"] ""
  incdir <- case excode2 of 
              ExitSuccess -> do  
                putStrLn $ out2
                return . head . words $ out2
              _ -> error "root-config failure" 

  let Just lib = library . localPkgDescr $ bInfo
      buildinfo = libBuildInfo lib

  let hbi = emptyBuildInfo { extraLibs = libs liboptset
                           , extraLibDirs = libdirs liboptset 
                           , includeDirs = incdir : includeDirs buildinfo
                           }
  putStrLn $ show hbi
  return (Just hbi, [])


data LibraryOptionSet = LibraryOptionSet { 
  libs :: [String], 
  libdirs :: [String], 
  libopts :: [String]
} deriving Show

data LibraryOption = Lib String 
                   | Dir String
                   | Opt String 
                   deriving Show

mkLibraryOptionSet :: [String] -> LibraryOptionSet
mkLibraryOptionSet strs = let opts = libraryOptions strs
                          in  foldr f (LibraryOptionSet [] [] []) opts 
  where f x (LibraryOptionSet l d o) = case x of
                                         Lib st -> LibraryOptionSet (st:l) d o 
                                         Dir st -> LibraryOptionSet l (st:d) o 
                                         Opt st -> LibraryOptionSet l d (st:o) 

libraryOptions :: [String] -> [LibraryOption] -- LibraryOptionSet 
libraryOptions = map f 
  where f x = let r = parse libraryOptionClassifier "" x
              in  case r of 
                    Left msg -> error (show msg)
                    Right result -> result


libraryOptionClassifier :: ParsecT String () Identity LibraryOption
libraryOptionClassifier = 
  try (string "-L" >> many1 anyChar >>= return . Dir) 
  <|> try (string "-l" >> many1 anyChar >>= return . Lib)
  <|> (many1 anyChar >>= return . Opt)