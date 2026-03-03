{
  lib,
  config,
  pkgs,
  ...
}:
/*
  Feature: Steam
  Provides: Steam game client with proper 32-bit, Vulkan and NVIDIA PRIME support.
  Enabling this feature will:
   - enable programs.steam (NixOS module, not a raw package)
   - enable 32-bit graphics stack required by Steam/games
   - open firewall ports for Steam Remote Play

  Steam launcher runs on Intel iGPU (saves battery).
  All games automatically run on NVIDIA dGPU via PRIME offload env vars
  injected through the package override — no duplicate icon in GNOME,
  no per-game launch options needed.
*/
let
  cfg = config.my.features.steam;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.steam.enable =
    mkEnableOption "Enable Steam game client with 32-bit and NVIDIA PRIME support";

  config = mkIf cfg.enable {
    # 32-bit OpenGL/Vulkan — required by Steam and most games
    hardware.graphics.enable32Bit = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;

      # Override the steam package to inject PRIME offload env vars into the
      # FHS environment. These are inherited by all child processes (games)
      # so they run on the NVIDIA dGPU automatically — same desktop icon, no duplicate.
      # The launcher UI itself (GTK) stays on iGPU as GTK ignores these vars.
      package = pkgs.steam.override {
        extraEnv = {
          __NV_PRIME_RENDER_OFFLOAD        = "1";
          __NV_PRIME_RENDER_OFFLOAD_RESET  = "1";
          __GLX_VENDOR_LIBRARY_NAME        = "nvidia";
          __VK_LAYER_NV_optimus            = "NVIDIA_only";
        };
      };
    };
  };
}
