{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.nvidia;
  inherit (lib) mkEnableOption mkIf mkOption types;
in
{
  options.my.features.nvidia = {
    enable = mkEnableOption "Enable NVIDIA proprietary driver and related settings";

    finegrainedPowerManagement = mkEnableOption ''
      Enable fine-grained power management (D3cold).
      Cuts idle power from ~6.5W to ~0.5W by fully cutting PCIe power when unused.
      May cause instability on some systems (black screen on wake, kernel panic).
      Safe to try — disable if you experience issues after waking from sleep
    '';

    prime = {
      enable = mkEnableOption "Enable NVIDIA PRIME for hybrid Intel/NVIDIA graphics";

      mode = mkOption {
        type = types.enum [ "offload" "sync" ];
        default = "offload";
        description = ''
          PRIME rendering mode:
          - offload: Intel renders by default, NVIDIA on demand via
                     `nvidia-offload <cmd>`. Best for battery life.
          - sync:    NVIDIA renders everything, output via Intel.
                     Best performance, higher power draw.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # NVIDIA-specific VA-API bridge — merges into hardware.graphics set by system/graphics.nix
    hardware.graphics.extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];

    # Load NVIDIA driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Power management settings
      powerManagement.enable = cfg.finegrainedPowerManagement;
      powerManagement.finegrained = cfg.finegrainedPowerManagement;

      # Use the NVIDIA open source kernel module? (Turing+ only)
      open = true;

      # Enable the NVIDIA settings tool (`nvidia-settings`)
      nvidiaSettings = true;

      # Select the driver package (adjust if you need a specific version)
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = lib.mkIf cfg.prime.enable {
        # ThinkPad X1 Extreme Gen 4: Intel UHD + RTX 3050 Ti
        intelBusId  = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = lib.mkIf (cfg.prime.mode == "offload") {
          enable = true;
          # Adds `nvidia-offload` wrapper command to run apps on dGPU
          enableOffloadCmd = true;
        };

        sync.enable = cfg.prime.mode == "sync";
      };
    };
  };
}
