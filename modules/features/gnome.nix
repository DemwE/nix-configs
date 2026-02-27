{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.gnome;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.gnome.enable = mkEnableOption "Enable GNOME desktop environment";

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.desktopManager.gnome.enable = true;

    # GNOME services
    services.gnome.gnome-keyring.enable = true;
    services.gnome.localsearch.enable = true;
    services.gnome.tinysparql.enable = true;

    programs.dconf.profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
          "org/gnome/desktop/interface" = {
            accent-color = "pink";
          };
          "org/gnome/desktop/input-sources" = {
            xkb-options = [ "ctrl:nocaps" ];
          };
        };
      }
    ];

    environment.systemPackages = with pkgs; [
      pkgs.gnomeExtensions.blur-my-shell
      pkgs.gnomeExtensions.appindicator
    ];

    # Exclude some default GNOME apps if desired
    # environment.gnome.excludePackages = with pkgs; [
    #   gnome-tour
    #   epiphany
    #   geary
    # ];
  };
}
