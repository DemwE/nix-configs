{ config, pkgs, ... }:

let
  modulesLeft = [
    "hyprland/workspaces"
  ];

  modulesCenter = [
    "hyprland/window"
  ];

  modulesRight = [
    "pulseaudio"
    "network"
    "custom/notification"
    "clock"
  ];
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        mod = "dock";
        margin-left = 10;
        margin-right = 10;
        margin-top = 7;
        margin-bottom = 0;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        reload_style_on_change = true;

        modules-left = modulesLeft;
        modules-center = modulesCenter;
        modules-right = modulesRight;

        upower = {
          icon-size = 20;
          format = "";
          format-alt = "{}<span color='orange'>[{time}]</span>";
          tooltip = true;
          tooltip-spacing = 20;
          on-click-right = "pkill waybar & hyprctl dispatch exec waybar";
        };

        "group/expand-4" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 600;
            children-class = "not-power";
            transition-to-left = true;
            click-to-reveal = true;
          };
          modules = [ "upower" ];
        };

        "custom/smallspacer" = {
          format = " ";
        };
        "custom/spacer" = {
          format = "|";
        };

        tray = {
          icon-size = 16;
          rotate = 0;
          spacing = 3;
        };

        "group/expand" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 600;
            children-class = "not-power";
            transition-to-left = true;
          };
          modules = [
            "custom/menu"
            "custom/spacer"
            "tray"
          ];
        };

        "custom/menu" = {
          format = "󰅃";
          rotate = 90;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "󰅸";
            none = "󰂜";
            dnd-notification = "󰅸";
            dnd-none = "󱏨";
            inhibited-notification = "󰅸";
            inhibited-none = "󰂜";
            dnd-inhibited-notification = "󰅸";
            dnd-inhibited-none = "󱏨";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click-right = "swaync-client -d -sw";
          on-click = "swaync-client -t -sw";
          escape = true;
        };

        "hyprland/window" = {
          format = "<span weight='bold'>{class}</span>";
          max-length = 120;
          icon = false;
          icon-size = 13;
        };

        "custom/power" = {
          format = "@{}";
          rotate = 0;
          on-click = "ags -t ControlPanel";
          on-click-right = "pkill ags";
          tooltip = true;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
        };

        # Padding modules
        "custom/l_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/r_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/sl_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/sr_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/rl_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/rr_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/padd" = {
          format = "  ";
          interval = "once";
          tooltip = false;
        };
      }
    ];
  };

  programs.waybar.style = ''
        @define-color mocha-base      #1e1e2e;
    @define-color mocha-mantle    #181825;
    @define-color mocha-crust     #11111b;
    @define-color mocha-surface0  #313244;
    @define-color mocha-surface1  #45475a;
    @define-color mocha-surface2  #585b70;
    @define-color mocha-overlay0  #6c7086;
    @define-color mocha-overlay1  #7f849c;
    @define-color mocha-overlay2  #9399b2;
    @define-color mocha-subtext0  #a6adc8;
    @define-color mocha-subtext1  #bac2de;
    @define-color mocha-text      #cdd6f4;
    @define-color mocha-lavender  #b4befe;
    @define-color mocha-blue      #89b4fa;
    @define-color mocha-sapphire  #74c7ec;
    @define-color mocha-sky       #89dceb;
    @define-color mocha-teal      #94e2d5;
    @define-color mocha-green     #a6e3a1;
    @define-color mocha-yellow    #f9e2af;
    @define-color mocha-peach     #fab387;
    @define-color mocha-maroon    #eba0ac;
    @define-color mocha-red       #f38ba8;
    @define-color mocha-mauve     #cba6f7;
    @define-color mocha-pink      #f5c2e7;
    @define-color mocha-flamingo  #f2cdcd;
    @define-color mocha-rosewater #f5e0dc;

    
  '';
}
