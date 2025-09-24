{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix      # Machine-specific hardware profile
    ../../modules                     # Aggregated modules (default.nix)
    ../../profiles/base.nix           # Base profile (kept for future shared logic)
    ../../profiles/desktop.nix        # Desktop feature bundle (enables Hyprland, etc.)
  ];

  # Bootloader configuration for UEFI systems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 8;
  # Use latest stable kernel for better hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking configuration
  networking.hostName = "DemwE_PC";
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true; # Allow unfree packages globally (NVIDIA, etc.)

  system.stateVersion = "25.05"; 
}
