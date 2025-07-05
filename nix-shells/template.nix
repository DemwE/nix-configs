{ pkgs ? import <nixpkgs> { } }:

let
  envBuildInputs = with pkgs; [
    # packages
  ];
  lib = import ./lib/default.nix { 
    name = "environment name"; 
    inherit pkgs; 
    buildInputs = envBuildInputs;
  };
in
pkgs.mkShell {
  inherit (lib) shellHook;

  # Define the build inputs for the environment
  buildInputs = envBuildInputs ++ lib.buildInputs;
}
