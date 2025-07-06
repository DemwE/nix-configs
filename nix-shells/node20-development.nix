{ pkgs ? import <nixpkgs> { } }:

let
  envBuildInputs = with pkgs; [
    nodejs_20
  ] ++ (import ./lib/node-packages.nix { inherit pkgs; });
  lib = import ./lib/default.nix { 
    name = "Node.js 20 Development"; 
    inherit pkgs; 
    buildInputs = envBuildInputs;
  };
in
pkgs.mkShell {
  inherit (lib) shellHook;

  # Define the build inputs for the environment
  buildInputs = envBuildInputs ++ lib.buildInputs;
}