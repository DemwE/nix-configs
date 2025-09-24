# Exposes a nixos-unstable package set under `pkgs.unstable`
# Usage: pkgs.unstable.<pkg>

final: prev:
let
  unstablePkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {
    inherit (prev) system;
    # Reuse the same nixpkgs configuration (e.g., allowUnfree)
    config = prev.config or {};
  };
in {
  unstable = unstablePkgs;
}
