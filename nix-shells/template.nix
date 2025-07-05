{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  inherit (import ./lib/default.nix { name = "environment name"; }) shellHook;

  # Define the build inputs for the environment
  buildInputs = with pkgs; [
    # packages
  ];
}
