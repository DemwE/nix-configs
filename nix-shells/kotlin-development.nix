{ pkgs ? import <nixpkgs> { } }:

let
  envBuildInputs = with pkgs; [
    kotlin
    openjdk21
    gradle
    maven
    ktlint
    detekt
  ];
  lib = import ./lib/default.nix {
    name = "Kotlin Development";
    inherit pkgs;
    buildInputs = envBuildInputs;
  };
in
pkgs.mkShell {
  inherit (lib) shellHook;

  # Define the build inputs for the environment
  buildInputs = envBuildInputs ++ lib.buildInputs;
}
