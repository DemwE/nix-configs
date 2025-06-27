{ config, pkgs, ... }:

let
  modulesLeft = [
    "custom/spacer"
    "hyprland/window"
  ];

  modulesCenter = [
    "hyprland/workspaces"
  ];

  modulesRight = [
    "pulseaudio"
    "custom/spacer"
    "network"
    "custom/spacer"
    "clock"
    "custom/spacer"
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
        margin-left = 14;
        margin-right = 14;
        margin-top = 8;
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

        pulseaudio = {
          format = "{icon} {volume}%";
          icon-size = 16;
          on-click = "pavucontrol";
          tooltip = false;
        };

        network = {
          format = " {bandwidthUpBytes}  {bandwidthDownBytes}";
          tooltip = false;
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%d %B %Y}";
          tooltip = false;
        };

        "hyprland/window" = {
          format = "<span weight='bold'>{class}</span>";
          max-length = 120;
          icon = false;
          icon-size = 13;
        };

        "custom/spacer" = {
          format = "  ";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = " ";
            active = " ";
          };
          show-special = false;
          all-outputs = false;
          active-only = false;
          persistent-workspaces = {
            "DP-1" = [
              1
              2
              3
            ];
          };
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

    * {
      border: none;
      border-radius: 0;
      font-family: "JetBrainsMono Nerd Font";
      font-weight: bold;
      font-size: 14px;
      min-height: 0;
      color: @mocha-text;
    }

    window#waybar {
      background: @mocha-base;
      border-radius: 10px;
      border: 2px solid @mocha-surface2;
    }

    #workspaces {
      background: transparent;
      margin: 5px;
      padding: 0px 5px;
      border-radius: 15px;
    }

    #workspaces button {
      padding: 0;
      margin: 3px;
      border-radius: 50%;
      border: none;
      min-width: 20px;
      min-height: 20px;
      background-color: @mocha-overlay0;
      color: @mocha-text;
      transition: all 0.3s ease-in-out;
    }

    #workspaces button.active {
      background-color: @mocha-lavender;
      color: @mocha-base;
      box-shadow: 0 0 6px @mocha-lavender;
    }

    #workspaces button:hover {
      background-color: @mocha-overlay2;
    }

    #workspaces button.active:hover {
      background-color: @mocha-sapphire;
    }
  '';
}
