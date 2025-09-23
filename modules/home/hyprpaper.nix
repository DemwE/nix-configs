{ my, lib, config, ... }:
let
  userEntries = my.theme.wallpapers;
  fallbackEntries = [
    { monitor = "DP-1"; path = "${config.home.homeDirectory}/.config/resources/wallpaper.jpg"; }
    { monitor = "HDMI-A-1"; path = "${config.home.homeDirectory}/.config/resources/wallpaper-alt.jpg"; }
  ];
  entries = if userEntries != [] then userEntries else fallbackEntries;
in
lib.mkIf my.features.hyprland.enable {
  services.hyprpaper = lib.mkIf (entries != [] ) {
    enable = true;
    settings = let
      preload = map (w: w.path) entries;
      wallpaper = map (w: "${w.monitor},${w.path}") entries;
    in { inherit preload wallpaper; };
  };
  # If no wallpapers configured, do nothing (Hyprland won't crash); user can add later.
}
