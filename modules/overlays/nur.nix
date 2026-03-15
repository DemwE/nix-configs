# Expose NUR (Nix User Repository) under `pkgs.nur`
# Usage: pkgs.nur.repos.<owner>.<pkg>

final: prev:
let
  nur = import <nur> {
    pkgs = prev;
  };
in {
  nur = nur;
}
