{ pkgs ? import <nixpkgs> { } }:

let
  envBuildInputs = with pkgs; [
    nodejs_24
  ] ++ (import ./lib/node-packages.nix { inherit pkgs; });
  lib = import ./lib/default.nix { 
    name = "Node.js 24 Development"; 
    inherit pkgs; 
    buildInputs = envBuildInputs;
  };
in
pkgs.mkShell {
  inherit (lib) shellHook;

  # Define the build inputs for the environment
  buildInputs = envBuildInputs ++ lib.buildInputs;
}
