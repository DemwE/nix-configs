{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.hyprland;
  inherit (lib) mkEnableOption mkIf;
 in {
  options.my.features.hyprland.enable = mkEnableOption "Enable Hyprland compositor and related environment variables";
  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    security.pam.services.hyprlock.enable = true;
    # Desktop portals for Hyprland
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
