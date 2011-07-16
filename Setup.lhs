#! /usr/bin/env runhaskell

> import Distribution.Simple
> import Distribution.Simple.Setup
> import Distribution.PackageDescription
> import Distribution.Simple.LocalBuildInfo
>
> import Config
>
> myconfigHook = simpleUserHooks { confHook = hookfunction } 
>
> hookfunction x y = do 
>   binfo <- confHook simpleUserHooks x y 
>   pbi <- config binfo
>   let pkg_descr = localPkgDescr binfo
>   
>   let newbinfo = binfo { localPkgDescr = updatePackageDescription pbi pkg_descr }
>   -- putStrLn (show (localPkgDescr newbinfo))
>   return newbinfo
>  
>
> main = defaultMainWithHooks myconfigHook
>

