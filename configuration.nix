{ pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./specialisations.nix
  ];

  # Allow unfree packages globally (NVIDIA, etc.)
  nixpkgs.config.allowUnfree = true;

  # Enable boot and networking via common modules
  my.boot.enable = true;
  my.boot.kernel = "unstable";

  my.networking.enable = true;
  my.networking.hostname = "NixBook";
  my.networking.openvpn = true;

  # Enable services
  my.services.ssh = true;
  my.services.printing = true;
  my.services.storage = true;
  my.services.firewall = true;

  # System channel and versioning
  system.stateVersion = "25.11";
}
