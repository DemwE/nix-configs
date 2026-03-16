# Exposes a nixos-unstable package set under `pkgs.unstable`
# Usage: pkgs.unstable.<pkg>

final: prev:
let
  pkgs-unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    sha256 = "0fgmdh1j6qrx64wq8wk2hry2rjh3rkvz9pch29l8zn49nlndvxy2";
  }) {
    system = prev.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in {
  unstable = pkgs-unstable;
}
