{ my, lib, ... }:
let
  p = my.theme.palette;
  accent = my.theme.accent;
  hexTo0x = hex: "0xff${lib.strings.removePrefix "#" hex}";
in
lib.mkIf my.features.hyprland.enable {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitors: primary + secondary (example placement)
      monitor = [
        "DP-1,2560x1440@165,0x0,1"
        "HDMI-A-1,1920x1080@60,-1080x-150,1,transform,1"
      ];

      # Input / pointer behaviour
      input = {
        kb_layout = "pl";
        repeat_rate = 25;
        repeat_delay = 600;
        sensitivity = 0.5;
        follow_mouse = 1;
        mouse_refocus = true;
        accel_profile = "flat";
      };

      general = {
        gaps_in = 10;
        gaps_out = 14;
        border_size = 2;
        layout = "dwindle"; # default tiling layout
      };

      dwindle = {
        pseudotile = true; # Keep window size when floating in tiling
        preserve_split = true; # Don't collapse splits when closing windows
        smart_split = true;
        smart_resizing = true;
        force_split = 2; # Prefer vertical splits on wide monitor
      };

      master = {
        new_is_master = true;
        mfact = 0.55;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
        };
        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "0x66000000";
        active_opacity = 1.0;
        inactive_opacity = 0.92;
        dim_inactive = false;
        dim_strength = 0.10;
        # Themed borders
        "col.active_border" = hexTo0x p.${accent};
        "col.inactive_border" = hexTo0x p.surface2;
        "col.group_border_active" = hexTo0x p.${accent};
        "col.group_border" = hexTo0x p.overlay0;
      };

      animations = {
        enabled = true;
        bezier = [
          "standard,0.05,0.9,0.1,1.0"
          "overshot,0.7,0.9,0.1,1.05"
        ];
        animation = [
          "windows,1,7,standard,slide"
          "windowsOut,1,7,standard,slide"
          "border,1,10,standard"
          "fade,1,6,standard"
          "workspaces,1,6,standard,slide"
        ];
      };

      # Environment variables passed to session
      env = [
        "XCURSOR_SIZE,24"
      ];

      # Autostart common components once session begins (Hyprland daemonized)
      exec-once = [
        "waybar"
        "hyprpaper"
        "dunst"
        # Start system tray helpers / portals
        "systemctl --user start xdg-desktop-portal-hyprland.service || true"
        # Polkit agent (if installed)
        "[workspace 1 silent] /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || true"
        # Discord delayed start (so wallpaper etc are ready)
        # "sleep 2 && discord --enable-features=UseOzonePlatform --ozone-platform=wayland"
      ];

      # Define static workspace to monitor mapping
      workspace = [
        "1, monitor:DP-1, default:true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:HDMI-A-1"
      ];

      # Themed cursor (example - adjust if you add a cursor theme)
      cursor = {
        inactive_timeout = 10;
      };

      windowrulev2 = [
        # Utility floats
        "float,class:(pavucontrol)"
        "size 900 520,class:(pavucontrol)"
        "move 60 60,class:(pavucontrol)"
        "float,title:(Picture-in-Picture)"

        # Discord & btop -> workspace 5 on second monitor (tiling, no forced size)
        "workspace 5,class:^(discord)$"
        "monitor HDMI-A-1,class:^(discord)$"
        "workspace 5,title:^(btop)$"
        "monitor HDMI-A-1,title:^(btop)$"

        # Slight transparency for file manager
        "opacity 0.95 0.95,class:(org.gnome.Nautilus)"
      ];

      misc = {
        focus_on_activate = true;
        force_default_wallpaper = 0; # keep custom wallpaper manager
        vfr = true;
        disable_hyprland_logo = true;
        swallow = true; # terminal swallowing (disable if undesired)
      };

      debug = {
        damage_tracking = 1;
      }; # reasonable default
    };
  };
}
