{ config, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrainsMono Nerd Font Mono 10";
        frame_color = "#89b4fa";
        separator_color = "frame";
        highlight = "#89b4fa";
        corner_radius = 10; 
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#fab387";
      };
    };
  };
}