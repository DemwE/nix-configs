# Expose NUR (Nix User Repository) under `pkgs.nur`
# Usage: pkgs.nur.repos.<owner>.<pkg>

final: prev:
let
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
  }) {
    pkgs = prev;
  };
in {
  nur = nur;
}
