{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.mobile-applets;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.mobile-applets.enable =
    mkEnableOption "Enable Waybar mobile applets (Wi‑Fi, Bluetooth, Bluetooth battery)";

  # Provide power and device services commonly needed by mobile applets
  config = mkIf cfg.enable {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
