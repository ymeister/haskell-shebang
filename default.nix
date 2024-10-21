{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let nix-thunk = import ./deps/nix-thunk { inherit pkgs; };
    deps = with nix-thunk; mapSubdirectories thunkSource ./deps;

    nix-shebang = import deps.nix-shebang { pkgs = pkgs; };
    haskell-shebang = nix-shebang.haskell;

    prelude-overlay = import (deps.haskell-prelude + "/overlay.nix") { inherit pkgs; };
    with-prelude-overlay = "${prelude-overlay}/bin/with-prelude-overlay";

in symlinkJoin {
  name = "haskell-shebang";
  paths = [
    (
      writeScriptBin "haskell-shebang" ''
        #!/bin/sh

        exec ${with-prelude-overlay} "${haskell-shebang}/bin/nix-haskell-shebang" -O2 -threaded -rtsopts -with-rtsopts=-N prelude "$@"
      ''
    )
    (
      writeScriptBin "haskell-repl" ''
        #!/bin/sh

        exec ${with-prelude-overlay} "${haskell-shebang}/bin/nix-haskell-repl" prelude "$@"
      ''
    )
  ];
}
