{ my, lib, ... }:
let
  p = my.theme.palette;
  accent = my.theme.accent;
  modulesLeft = [ "custom/spacer" "hyprland/window" ];
  modulesCenter = [ "hyprland/workspaces" ];
  modulesRight = [ "pulseaudio" "custom/spacer" "network" "custom/spacer" "clock" "custom/spacer" ];
in lib.mkIf my.features.hyprland.enable {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [ {
      layer = "top";
      position = "top";
      mod = "dock";
      margin-left = 14; margin-right = 14; margin-top = 8; margin-bottom = 0;
      exclusive = true; passthrough = false; gtk-layer-shell = true; reload_style_on_change = true;
      modules-left = modulesLeft;
      modules-center = modulesCenter;
      modules-right = modulesRight;
      pulseaudio = { format = "{icon} {volume}%"; icon-size = 16; on-click = "pavucontrol"; tooltip = false; };
      network = { format = " {bandwidthUpBits}  {bandwidthDownBits}"; tooltip = false; };
      clock = { format = "{:%H:%M}"; format-alt = "{:%d %B %Y}"; tooltip = false; };
      "hyprland/window" = { format = "<span weight='bold'>{class}</span>"; max-length = 120; icon = false; icon-size = 13; };
      "custom/spacer" = { format = "  "; };
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = { default = " "; active = " "; };
        show-special = false; all-outputs = false; active-only = false;
        persistent-workspaces = { "DP-1" = [ 1 2 3 ]; };
      };
    } ];
    style = ''
      /* Catppuccin via centralized palette */
      @define-color base      ${p.base};
      @define-color mantle    ${p.mantle};
      @define-color crust     ${p.crust};
      @define-color surface0  ${p.surface0};
      @define-color surface1  ${p.surface1};
      @define-color surface2  ${p.surface2};
      @define-color overlay0  ${p.overlay0};
      @define-color overlay1  ${p.overlay1};
      @define-color overlay2  ${p.overlay2};
      @define-color subtext0  ${p.subtext0};
      @define-color subtext1  ${p.subtext1};
      @define-color text      ${p.text};
      @define-color accent    ${p.${accent} or p.lavender};

      * { border: none; border-radius: 0; font-family: ${my.theme.font.family}; font-weight: bold; font-size: 14px; min-height: 0; color: @text; }
      window#waybar { background: @base; border-radius: 10px; border: 2px solid @surface2; }
      #workspaces { background: transparent; margin: 5px; padding: 0 5px; border-radius: 15px; }
      #workspaces button { padding: 0; margin: 3px; border-radius: 50%; background-color: @overlay0; color: @text; min-width: 20px; min-height: 20px; transition: all 0.3s ease-in-out; }
      #workspaces button.active { background-color: @accent; color: @base; box-shadow: 0 0 6px @accent; }
      #workspaces button:hover { background-color: @overlay2; }
      #workspaces button.active:hover { background-color: ${p.sapphire}; }
    '';
  };
}
