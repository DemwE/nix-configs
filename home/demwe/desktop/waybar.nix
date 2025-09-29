{ config, pkgs, ... }:

let
  useMobileApplets = (config.nixosConfig or { my = { features = { mobile-applets = { enable = false; }; }; }; }).my.features.mobile-applets.enable;
  modulesLeft = [
    "custom/spacer"
    "hyprland/window"
  ];

  modulesCenter = [
    "hyprland/workspaces"
  ];

  baseRight = [
    "pulseaudio"
    "custom/spacer"
  ];

  mobileRight = [
    "network"
    "custom/spacer"
    "bluetooth"
    "custom/spacer"
    "battery"
    "custom/spacer"
  ];

  tailRight = [
    "clock"
    "custom/spacer"
  ];

  modulesRight = baseRight ++ (if useMobileApplets then mobileRight else [ "network" "custom/spacer" ]) ++ tailRight;
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
          # When mobile applets are enabled, show connection state; otherwise bandwidth
          format = if useMobileApplets then "{ifname} {icon} {signalStrength}%" else " {bandwidthUpBits}  {bandwidthDownBits}";
          format-wifi = "  {essid} {signalStrength}%";
          format-ethernet = "󰈀   {bandwidthUpBits}  {bandwidthDownBits}";
          format-disconnected = "󰤭  offline";
          tooltip = true;
          tooltip-format = "{ipaddr}\n{gwaddr}";
        };

        bluetooth = {
          format = " {status}";
          format-connected = " {num_connected} conn";
          format-disabled = " off";
          tooltip = true;
          on-click = "blueman-manager";
        };

        battery = {
          # Hidden automatically on desktops without a battery
          interval = 10;
          states = {
            good = 80;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{timeTo} {capacity}%";
          tooltip = true;
          # Icons pulled from Nerd Font set
          format-icons = [
            "󰁺" # 10%
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹" # 100%
          ];
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

  programs.waybar.style = let p = config.my.theme.palette; in ''
    @define-color mocha-base      ${p.base};
    @define-color mocha-mantle    ${p.mantle};
    @define-color mocha-crust     ${p.crust};
    @define-color mocha-surface0  ${p.surface0};
    @define-color mocha-surface1  ${p.surface1};
    @define-color mocha-surface2  ${p.surface2};
    @define-color mocha-overlay0  ${p.overlay0};
    @define-color mocha-overlay1  ${p.overlay1};
    @define-color mocha-overlay2  ${p.overlay2};
    @define-color mocha-subtext0  ${p.subtext0};
    @define-color mocha-subtext1  ${p.subtext1};
    @define-color mocha-text      ${p.text};
    @define-color mocha-lavender  ${p.lavender};
    @define-color mocha-blue      ${p.blue};
    @define-color mocha-sapphire  ${p.sapphire};
    @define-color mocha-sky       ${p.sky};
    @define-color mocha-teal      ${p.teal};
    @define-color mocha-green     ${p.green};
    @define-color mocha-yellow    ${p.yellow};
    @define-color mocha-peach     ${p.peach};
    @define-color mocha-maroon    ${p.maroon};
    @define-color mocha-red       ${p.red};
    @define-color mocha-mauve     ${p.mauve};
    @define-color mocha-pink      ${p.pink};
    @define-color mocha-flamingo  ${p.flamingo};
    @define-color mocha-rosewater ${p.rosewater};

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
