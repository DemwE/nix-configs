{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "DP-1,2560x1440@165,0x0,1"
        "HDMI-A-1,1920x1080@60,-1080x-150,1,transform,1"
      ];

      input = {
        kb_layout = "pl";
        repeat_rate = 25;
        repeat_delay = 600;
        sensitivity = 1.0;
        follow_mouse = 1;
        mouse_refocus = true;

        touchpad = {
          disable_while_typing = true;
          tap-to-click = true;
        };
      };

      dwindle = {
        pseudotile = false;
        force_split = 0;
        preserve_split = false;
        smart_split = false;
        smart_resizing = true;
        permanent_direction_override = false;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        default_split_ratio = 1.0;
      };

      master = {
        allow_small_split = false;
        special_scale_factor = 0.8;
        mfact = 0.55;
        new_status = "slave";
        new_on_top = false;
        new_on_active = "none";
        orientation = "left";
        inherit_fullscreen = true;
        smart_resizing = true;
        drop_at_cursor = true;
      };

      misc = {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
      };

      workspace = [
        "1,monitor:DP-1"
        "2,monitor:DP-1"
        "3,monitor:DP-1"
        "4,monitor:DP-1"
        "5,monitor:DP-1"
        "6,monitor:DP-1"
        "7,monitor:DP-1"
        "8,monitor:HDMI-A-1"
      ];

      decoration = {
        rounding = 10;
        rounding_power = 2;
        

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      general = {
        gaps_in = 10; # Gaps between windows
        gaps_out = 14; # Gaps between windows and screen edges
        border_size = 2; # Size of the window borders
        "col.active_border" = "rgba(b7bdf8ff)"; # Color of the active window border
        "col.inactive_border" = "rgba(585b70ff)"; # Color of the inactive window border
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Window rules
      windowrulev2 = [
        "float,class:^(qalculate-gtk)$"
      ];
    };
  };
}
