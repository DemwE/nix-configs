{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  inherit (import ./lib/default.nix { name = "Node.js 24 Development"; }) shellHook;

  # Define the build inputs for the environment
  buildInputs = with pkgs; [
    nodejs_24
  ] ++ (import ./lib/node-packages.nix { inherit pkgs; });
}
