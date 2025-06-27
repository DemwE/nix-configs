{ config, lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        hide_cursor = true;
      };
      background = [
        {
          monitor = "DP-1"; # Default monitor (primary)
          path = toString .././config-resources/wallpaper.jpg;
          blur_passes = 3;
          blur_size = 8;
        }
        {
          monitor = "HDMI-A-1"; # Second monitor
          path = toString .././config-resources/wallpaper-alt.jpg;
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      image = [
        {
          path = toString .././config-resources/avatar.jpg;
          monitor = "DP-1"; # Default monitor (primary)
          size = 150;
          border_size = 4;
          border_color = "rgb(36, 39, 58)";
          rounding = -1; # Negative means circle
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "DP-1"; # Default monitor (primary)
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(54, 58, 79)";
          border_color = "rgb(36, 39, 58)";
          border_size = 4;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };
}
