{ my, lib, config, ... }:
let
  p = my.theme.palette;
  avatar = if my.theme.lock.avatar != null then my.theme.lock.avatar else "${config.home.homeDirectory}/.config/resources/avatar.jpg";
  wl = if my.theme.wallpapers != [] then my.theme.wallpapers else [
    { monitor = "DP-1"; path = "${config.home.homeDirectory}/.config/resources/wallpaper.jpg"; }
    { monitor = "HDMI-A-1"; path = "${config.home.homeDirectory}/.config/resources/wallpaper-alt.jpg"; }
  ];
  firstWallpaper = if (wl != [] && builtins.hasAttr "path" (builtins.head wl)) then (builtins.head wl).path else null;
in lib.mkIf my.features.hyprland.enable {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0; # seconds after locking where unlock is instant
        hide_cursor = true;
        no_fade_in = false;
      };

      background = lib.optional (firstWallpaper != null) {
        path = firstWallpaper;
        blur_passes = 1;
        blur_size = 4;
        contrast = 1.0;
        brightness = 0.95;
        vibrancy = 0.05;
      };

      image = lib.optional (avatar != null) {
        path = avatar;
        size = 160;
        border_size = 6;
        border_color = p.${my.theme.accent};
        rounding = -1;
        reload_time = 0;
        position = "0, -140"; # Slightly above center
        halign = "center";
        valign = "center";
      };

      label = [
        {
          text = "cmd[update:1000] date +%H:%M";
          color = p.text;
          font_size = 64;
          font_family = my.theme.font.family;
          position = "0, 40"; # below avatar
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 8;
        }
        {
          text = "cmd[update:60000] date +%A,\\ %d %B";
          color = p.subtext1;
          font_size = 20;
          font_family = my.theme.font.family;
          position = "0, 110";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "320,60";
            position = "0, 190";
            halign = "center";
            valign = "center";
            outline_thickness = 0;
            font_color = p.text;
            inner_color = p.surface0;
            outer_color = p.surface2;
            border_color = p.${my.theme.accent};
            border_size = 3;
            rounding = 12;
            placeholder_text = "<i>Type to unlock...</i>";
            fail_color = p.red;
            check_color = p.green;
            capslock_color = p.peach;
            disable_input = false;
            shadow_passes = 1;
            shadow_size = 10;
        }
      ];
    };
  };
}
