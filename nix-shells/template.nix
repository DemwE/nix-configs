{ pkgs ? import <nixpkgs> { } }:

let
  envBuildInputs = with pkgs; [
    # package names
  ];
  lib = import ./lib/default.nix { 
    name = "Template"; 
    inherit pkgs; 
    buildInputs = envBuildInputs;
  };
in
pkgs.mkShell {
  inherit (lib) shellHook;

  # Define the build inputs for the environment
  buildInputs = envBuildInputs ++ lib.buildInputs;
}