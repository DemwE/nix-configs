{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.sddm;
  theme = config.my.theme;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.sddm.enable =
    mkEnableOption "Enable SDDM display manager with themed Catppuccin style";
  config = mkIf cfg.enable {
    services.xserver.enable = true; # Ensure X server base when SDDM is enabled
    environment.systemPackages = [
      (pkgs.catppuccin-sddm.override {
        flavor = theme.flavor;
        font = theme.font.family;
        fontSize = theme.font.sizeSDDM;
        # Fixed login background (uses main wallpaper from resources)
        background = toString ../../resources/wallpaper.jpg;
        loginBackground = true;
      })
    ];
    services.displayManager.sddm = {
      enable = true;
      theme = theme.sddmTheme;
      package = pkgs.kdePackages.sddm;
    };
  };
}
