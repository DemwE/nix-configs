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
   - open firewall ports for Steam Remote Play

  32-bit graphics stack is provided by system/graphics.nix (not duplicated here).
  If NVIDIA PRIME offload is enabled, games automatically run on dGPU via env
  vars injected into Steam's FHS environment — no per-game launch options needed.
*/
let
  cfg = config.my.features.steam;
  nvidiaPrime = config.my.features.nvidia.prime.enable or false;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.steam.enable =
    mkEnableOption "Enable Steam game client with 32-bit and NVIDIA PRIME support";

  config = mkIf cfg.enable {
    # 32-bit is already enabled in system/graphics.nix — no need to repeat here.

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;

      # When NVIDIA PRIME offload is active, inject PRIME env vars into Steam's
      # FHS environment so all child processes (games) automatically run on the
      # dGPU. The launcher UI (GTK) ignores these vars — stays on iGPU.
      # Same desktop icon, no duplicate, no per-game launch options needed.
      package = mkIf nvidiaPrime (pkgs.steam.override {
        extraEnv = {
          __NV_PRIME_RENDER_OFFLOAD       = "1";
          __NV_PRIME_RENDER_OFFLOAD_RESET = "1";
          __GLX_VENDOR_LIBRARY_NAME       = "nvidia";
          __VK_LAYER_NV_optimus           = "NVIDIA_only";
        };
      });
    };
  };
}
