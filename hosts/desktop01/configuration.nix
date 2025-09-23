{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
    ../../modules/packages.nix
    ../../modules/services.nix
    ../../modules/users/demwe.nix
    ../../modules/features/docker.nix
    ../../modules/features/qemu.nix
    ../../modules/features/polkit.nix
    ../../modules/system/locale-input.nix
    ../../modules/system/nix-settings.nix
    ../../modules/system/shell.nix
    ../../modules/system/fonts.nix
    ../../modules/groups/custom-groups.nix
    ../../modules/theme/core.nix
    ../../modules/features/hyprland.nix
    ../../modules/features/sddm.nix
    ../../profiles/base.nix
    ../../profiles/desktop.nix
  ];

  # Bootloader (systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 8;

  networking.hostName = "DemwE_PC";

  # Feature flags provided via profiles (no host overrides currently)

  nixpkgs.config.allowUnfree = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";
}
