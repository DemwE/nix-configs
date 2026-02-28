{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  # Bootloader configuration for UEFI systems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 8;
  # Use latest stable kernel for better hardware support
  boot.kernelPackages = pkgs.unstable.linuxPackages;

  # Networking configuration
  networking.hostName = "DemwE_PC";
  networking.networkmanager.enable = true;
  
  # Allow unfree packages globally (NVIDIA, etc.)
  nixpkgs.config.allowUnfree = true; 

  # Common packages for all systems
  environment.systemPackages = with pkgs; [
    neovim
    zsh
    fastfetch
    btop
    duf
    tree
    wget
    git
    yazi
    bat
  ];

  # Enable features
  my.features.nvidia.enable = true;
  my.features.docker.enable = false;
  my.features.flatpak.enable = true;
  my.features.qemu.enable = false;
  my.features.polkit.enable = true;
  my.features.gdm.enable = true;
  my.features.gnome.enable = true;

  # Sytem channel and versioning
  system.stateVersion = "25.11"; 
}
