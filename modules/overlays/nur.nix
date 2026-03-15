# Expose NUR (Nix User Repository) under `pkgs.nur`
# Usage: pkgs.nur.repos.<owner>.<pkg>

{ inputs, final, prev }:
let
  nur = import inputs.nur {
    pkgs = prev;
  };
in {
  nur = nur;
}
