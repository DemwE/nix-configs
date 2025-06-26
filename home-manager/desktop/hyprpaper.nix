{ config, pkgs, lib, ... }:

let
  wallpaper = toString .././config-resources/wallpaper.jpg;
in
{
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      preload = [
        wallpaper
      ];
      wallpaper = [
        "DP-1,${wallpaper}"
        "HDMI-A-1,${wallpaper}"
      ];
    };
  };
}
