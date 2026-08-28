{ config, pkgs, ... }:
let
  wallpaper = "file://${config.my.paths.resources}/demwe/wallpaper.jpg";
  lockBackground = "file://${config.my.paths.resources}/demwe/lock-background.jpg";
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
      "org/gnome/desktop/applications/terminal" = {
        exec = "blackbox";
        exec-arg = "";
      };
      "org/gnome/shell" = {
        always-show-log-out = true;
      };

      "org/gnome/settings-daemon/plugins/power" = {
        idle-dim = true;
        idle-delay = 300;
        sleep-inactive-battery-type = "suspend";
        sleep-inactive-battery-timeout = 900;
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-ac-timeout = 0;
        lid-close-ac-action = "suspend";
        lid-close-battery-action = "suspend";
      };
    };
  };
}
