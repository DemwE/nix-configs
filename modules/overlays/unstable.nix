# Exposes a nixos-unstable package set under `pkgs.unstable`
# Usage: pkgs.unstable.<pkg>

final: prev:
let
  unstablePkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {
    system = prev.stdenv.hostPlatform.system;
    config = prev.config or {};
  };
in {
  unstable = unstablePkgs;
}
