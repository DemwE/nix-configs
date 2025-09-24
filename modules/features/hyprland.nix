{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.hyprland;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.hyprland.enable =
    mkEnableOption "Enable Hyprland compositor (Wayland) and related integrations";
  config = mkIf cfg.enable {
    # Compositor + XWayland bridge
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    # Environment tweaks for cursor + ozone
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    # Hyprlock PAM entry
    security.pam.services.hyprlock.enable = true;
    # Portals for proper XDG integration (Wayland aware)
    xdg.portal.enable = true;
    # Include GTK portal alongside Hyprland for better file pickers and app integration
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    # Desktop session utilities specific to graphical environment
    environment.systemPackages = [
      pkgs.dconf
      pkgs.gnome-keyring
    ];
    # Secret storage integration (GNOME Keyring components)
    services.gnome.gnome-keyring.enable = true;
  };
}
