{
  my,
  lib,
  pkgs,
  ...
}:
lib.mkIf my.features.hyprland.enable {
  wayland.windowManager.hyprland.settings = {
    # Key bindings
    bind = [
      # Launchers / basics
      "SUPER, Return, exec, kitty"
      "SUPER, D, exec, rofi -show drun"
      "SUPER, W, exec, brave"
      "SUPER SHIFT, Q, killactive," # more intentional quit
      "SUPER, Q, togglespecialworkspace,scratch"
      "SUPER, F, fullscreen, 0"
      "SUPER, Space, togglefloating,"
      "SUPER, L, exec, hyprlock"
      "SUPER, Escape, exec, wlogout"

      # Workspaces 1-10
      "SUPER, 1, workspace,1"
      "SUPER, 2, workspace,2"
      "SUPER, 3, workspace,3"
      "SUPER, 4, workspace,4"
      "SUPER, 5, workspace,5"
      "SUPER, 6, workspace,6"
      "SUPER, 7, workspace,7"
      "SUPER, 8, workspace,8"
      "SUPER, 9, workspace,9"
      "SUPER, 0, workspace,10"

      # Move focused window to workspace (keep focus)
      "SUPER SHIFT, 1, movetoworkspace,1"
      "SUPER SHIFT, 2, movetoworkspace,2"
      "SUPER SHIFT, 3, movetoworkspace,3"
      "SUPER SHIFT, 4, movetoworkspace,4"
      "SUPER SHIFT, 5, movetoworkspace,5"
      "SUPER SHIFT, 6, movetoworkspace,6"
      "SUPER SHIFT, 7, movetoworkspace,7"
      "SUPER SHIFT, 8, movetoworkspace,8"
      "SUPER SHIFT, 9, movetoworkspace,9"
      "SUPER SHIFT, 0, movetoworkspace,10"

      # Focus movement (vi-like)
      "SUPER, H, movefocus,l"
      "SUPER, L, movefocus,r"
      "SUPER, K, movefocus,u"
      "SUPER, J, movefocus,d"

      # Swap windows
      "SUPER SHIFT, H, swapwindow,l"
      "SUPER SHIFT, L, swapwindow,r"
      "SUPER SHIFT, K, swapwindow,u"
      "SUPER SHIFT, J, swapwindow,d"

      # Resize (pseudo - using resizeactive)
      "SUPER CTRL, H, resizeactive,-40 0"
      "SUPER CTRL, L, resizeactive,40 0"
      "SUPER CTRL, K, resizeactive,0 -40"
      "SUPER CTRL, J, resizeactive,0 40"

      # Screenshots (whole / selection / active window)
      "SUPER, Print, exec, grim - | wl-copy"
      "SUPER SHIFT, Print, exec, grim -g $(slurp) - | wl-copy"
      "ALT, Print, exec, grim -g $(hyprctl activewindow -j | jq -r '.at[0]|tostring+\",\"+.at[1]|tostring+\",\"+.size[0]|tostring+\",\"+.size[1]|tostring') - | wl-copy"

      # Audio
      "SUPER, XF86AudioRaiseVolume, exec, pamixer -i 5"
      "SUPER, XF86AudioLowerVolume, exec, pamixer -d 5"
      "SUPER, XF86AudioMute, exec, pamixer -t"
      "SUPER, XF86AudioMicMute, exec, pamixer --default-source -t"

      # Media
      "SUPER, XF86AudioPlay, exec, playerctl play-pause"
      "SUPER, XF86AudioNext, exec, playerctl next"
      "SUPER, XF86AudioPrev, exec, playerctl previous"

      # Brightness
      "SUPER, XF86MonBrightnessUp, exec, brightnessctl set +5%"
      "SUPER, XF86MonBrightnessDown, exec, brightnessctl set 5%-"

      # Color picker + clipboard
      "SUPER, P, exec, hyprpicker -a"
      "SUPER, V, exec, wl-paste | notify-send 'Clipboard' --icon=dialog-information"
      "SUPER, B, exec, kitty --title btop btop"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    # Special workspace scratchpad terminal
    exec-once = [
      "[workspace special:scratch silent] kitty --class scratchpad --title scratchpad"
    ];

    windowrulev2 = [
      "float,class:(pavucontrol)"
      "float,title:(Picture-in-Picture)"
      "size 1200 700,class:(scratchpad)"
      "move 60 60,class:(pavucontrol)"
      "workspace special:scratch,class:(scratchpad)"
      "opacity 0.95 0.95,class:(org.gnome.Nautilus)"
    ];
  };
}
