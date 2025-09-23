{ config, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = let p = config.my.theme.palette; in {
        font = "JetBrainsMono Nerd Font Mono 10";
        frame_color = p.blue;
        separator_color = "frame";
        highlight = p.blue;
        corner_radius = 10; 
      };
      urgency_low = let p = config.my.theme.palette; in {
        background = p.base;
        foreground = p.text;
      };
      urgency_normal = let p = config.my.theme.palette; in {
        background = p.base;
        foreground = p.text;
      };
      urgency_critical = let p = config.my.theme.palette; in {
        background = p.base;
        foreground = p.text;
        frame_color = p.peach;
      };
    };
  };
}