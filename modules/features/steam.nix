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
   - when NVIDIA PRIME offload is also enabled, launch Steam and games
     on the dGPU automatically via __NV_PRIME_RENDER_OFFLOAD
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
    # 32-bit OpenGL/Vulkan — required by Steam and most games
    hardware.graphics.enable32Bit = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      # If PRIME offload is active, force Steam (and all launched games)
      # onto the NVIDIA dGPU automatically — no per-game launch options needed.
      package = mkIf nvidiaPrime (pkgs.steam.override {
        extraEnv = {
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
        };
      });
    };
  };
}
