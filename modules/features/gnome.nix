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
    
    # Exclude some default GNOME apps if desired
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      epiphany
      geary
    ];
  };
}
