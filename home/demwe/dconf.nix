{ config, ... }:
let
  wallpaper = "file://${config.my.paths.resources}/wallpaper.jpg";
  lockBackground = "file://${config.my.paths.resources}/lock-background.jpg";
in
{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/background" = {
        picture-uri = wallpaper;
        picture-uri-dark = wallpaper;
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = lockBackground;
        picture-uri-dark = lockBackground;
      };
    };
  };
}
