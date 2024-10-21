final: prev:

let nix-thunk = import ../deps/nix-thunk { pkgs = prev; };
    deps = with nix-thunk; mapSubdirectories thunkSource ../deps;

in {
  haskellPackages = prev.haskellPackages.extend (self: super: {
    prelude = self.callCabal2nix "prelude" deps.haskell-prelude {};
  });
}
