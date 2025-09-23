{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.sddm;
  theme = config.my.theme;
  inherit (lib) mkEnableOption mkIf;
  backgroundFile = "${config.my.paths.resources}/login-background.jpg";
in {
  options.my.features.sddm.enable = mkEnableOption "Enable SDDM display manager (Catppuccin themed)";
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    environment.systemPackages = [
      (pkgs.catppuccin-sddm.override {
        flavor = theme.flavor;
        font = theme.font.family;
        fontSize = theme.font.sizeSDDM;
        background = backgroundFile;
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