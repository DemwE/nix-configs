{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.nvidia;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.nvidia.enable =
    mkEnableOption "Enable NVIDIA proprietary driver and related settings";

  config = mkIf cfg.enable {
    # Enable OpenGL/graphics stack
    hardware.graphics = {
      enable = true;
    };

    # Load NVIDIA driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Power management settings
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # Use the NVIDIA open source kernel module? (Turing+ only)
      open = false;

      # Enable the NVIDIA settings tool (`nvidia-settings`)
      nvidiaSettings = true;

      # Select the driver package (adjust if you need a specific version)
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
