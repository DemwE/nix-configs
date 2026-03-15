# Exposes a nixos-unstable package set under `pkgs.unstable`
# Usage: pkgs.unstable.<pkg>

{ inputs, final, prev }:
let
  unstablePkgs = import inputs.nixpkgs {
    system = prev.stdenv.hostPlatform.system;
    config = prev.config or {};
  };
in {
  unstable = unstablePkgs;
}
