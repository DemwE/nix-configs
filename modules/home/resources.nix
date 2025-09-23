{ config, ... }:
{
  config.home.file = {
    "resources/wallpaper.jpg".source = ../../resources/wallpaper.jpg;
    "resources/wallpaper-alt.jpg".source = ../../resources/wallpaper-alt.jpg;
    "resources/avatar.jpg".source = ../../resources/avatar.jpg;
    "resources/rofi-background.jpg".source = ../../resources/rofi-background.jpg;
  };
}