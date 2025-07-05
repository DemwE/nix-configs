{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  inherit (import ./lib/default.nix { name = "C Development"; }) shellHook;

  # Define the build inputs for the environment
  buildInputs = with pkgs; [
    gcc
    gmp
  ];
}
