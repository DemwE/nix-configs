{ config, pkgs, lib, ... }:
let
  resources = config.my.paths.resources;
  wallpaper = "${resources}/wallpaper.jpg";
  wallpaper-alt = "${resources}/wallpaper-alt.jpg";
in {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      preload = [
        wallpaper
        wallpaper-alt
      ];
      wallpaper = [
        "DP-1,${wallpaper}"
        "HDMI-A-1,${wallpaper-alt}"
      ];
    };
  };
}
