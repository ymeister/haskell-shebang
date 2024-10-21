{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let nix-thunk = import ./deps/nix-thunk { inherit pkgs; };
    deps = with nix-thunk; mapSubdirectories thunkSource ./deps;

    nix-shebang = import deps.nix-shebang { pkgs = pkgs; };
    haskell-shebang = nix-shebang.haskell;

in writeScriptBin "haskell-shebang" ''
  #!/bin/sh

  export NIX_PATH="$NIX_PATH:nixpkgs-overlays=${./.}/overlays"

  exec "${haskell-shebang}/bin/nix-haskell-shebang" prelude "$@"
''
