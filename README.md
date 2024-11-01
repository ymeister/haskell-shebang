```
#!/usr/bin/env nix
#!nix shell --no-write-lock-file github:ymeister/haskell-shebang --command sh -c ``haskell-shebang shh -- "$@"`` sh

{-# LANGUAGE NoImplicitPrelude, PackageImports #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE TemplateHaskell #-}

import "prelude" Prelude
import Shh

$(loadEnv SearchPath)



main :: IO ()
main = do
  args <- getArgs

  if null args then do
    echo "Hello World!"
  else do
    echo $ "Hello" : args
```
