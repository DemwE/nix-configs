{ my, lib, ... }:
let p = my.theme.palette; in lib.mkIf my.features.hyprland.enable {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "${my.theme.font.family} 10";
        frame_color = p.blue;
        separator_color = "frame";
        highlight = p.blue;
        corner_radius = 10;
      };
      urgency_low = {
        background = p.base;
        foreground = p.text;
      };
      urgency_normal = {
        background = p.base;
        foreground = p.text;
      };
      urgency_critical = {
        background = p.base;
        foreground = p.text;
        frame_color = p.peach;
      };
    };
  };
}
