{ config, lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        hide_cursor = true;
        fade = {
          fadeIn = true;
          fadeOut = true;
        };
      };
      background = [
        {
          path = toString .././config-resources/wallpaper.jpg;
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      image = [
        {
          path = toString .././config-resources/avatar.jpg;
          size = 150;
          border_size = 4;
          border_color = "rgb(cba6f7)";
          rounding = -1; # Negative means circle
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(cdd6f4)";
          inner_color = "rgb(313244)";
          outer_color = "rgb(1e1e2e)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };
}