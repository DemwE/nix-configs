{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.sddm;
  theme = config.my.theme;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.sddm.enable = mkEnableOption "Enable SDDM display manager (Catppuccin themed)";
  config = mkIf cfg.enable {
    # Ensure X server basics (for SDDM login screen)
    services.xserver.enable = true;
    # Install themed SDDM package variant
    environment.systemPackages = [ (pkgs.catppuccin-sddm.override {
      flavor = theme.flavor;
      font = theme.font.family;
      fontSize = theme.font.sizeSDDM;
      # Use centralized resources path
      background = "${config.my.paths.resources}/wallpaper.jpg";
      loginBackground = true;
    }) ];
    # Core SDDM settings
    services.displayManager.sddm = {
      enable = true;
      theme = theme.sddmTheme;
      package = pkgs.kdePackages.sddm;
    };
  };
}
