{ pkgs ? import <nixpkgs> { } }:

let
  envBuildInputs = with pkgs; [
    gcc
    gmp
  ];
  lib = import ./lib/default.nix { 
    name = "C Development"; 
    inherit pkgs; 
    buildInputs = envBuildInputs;
  };
in
pkgs.mkShell {
  inherit (lib) shellHook;

  # Define the build inputs for the environment
  buildInputs = envBuildInputs ++ lib.buildInputs;
}
