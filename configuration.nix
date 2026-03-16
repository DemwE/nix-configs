{ pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./specialisations.nix
  ];

  # Allow unfree packages globally (NVIDIA, etc.)
  nixpkgs.config.allowUnfree = true;

  # System channel and versioning
  system.stateVersion = "25.11";
}
