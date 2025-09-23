{ config, pkgs, ... }:
let
  wallpaper = "${config.my.paths.resources}/wallpaper.jpg";
  wallpaperAlt = "${config.my.paths.resources}/wallpaper-alt.jpg";
in {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      preload = [
        wallpaper
        wallpaperAlt
      ];
      wallpaper = [
        "DP-1,${wallpaper}"
        "HDMI-A-1,${wallpaperAlt}"
      ];
    };
  };
}
