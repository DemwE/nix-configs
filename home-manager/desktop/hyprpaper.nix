{ config, pkgs, lib, ... }:

let
  wallpaper = toString .././config-resources/wallpaper.jpg;
  wallpaper-alt = toString .././config-resources/wallpaper-alt.jpg;
in
{
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
