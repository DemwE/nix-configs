{ ... }:

let
  terminal = "kitty";
  browser = "brave";
  editor = "code";
  files = "thunar";
in
{
  wayland.windowManager.hyprland.settings = {
    # Keyboard Buttons
    bind = [
      # Terminal
      "SUPER, Return, exec, ${terminal}"
      "SUPER_SHIFT, Return, exec, ${terminal} -f"
      "SUPER, T, exec, ${terminal} -F"

      # Apps
      "SUPER, D, exec, rofi -show drun"
      "SUPER_SHIFT, F, exec, ${files}"
      "SUPER_SHIFT, E, exec, ${editor}"
      "SUPER_SHIFT, W, exec, ${browser}"

      # Hyprland
      "SUPER, Q, killactive,"
      "SUPER, C, killactive,"
      "CTRL_ALT, Delete, exit,"
      "SUPER, F, fullscreen, 0"
      "SUPER, S, pseudo,"
      "SUPER, Space, togglefloating,"
      "SUPER, Space, centerwindow,"

      # Change Focus
      "SUPER, left,  movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up,    movefocus, u"
      "SUPER, down,  movefocus, d"

      # Move Active
      "SUPER_SHIFT,left,movewindow,l"
      "SUPER_SHIFT,right,movewindow,r"
      "SUPER_SHIFT,up,movewindow,u"
      "SUPER_SHIFT,down,movewindow,d"

      # Resize Active
      "SUPER_CTRL,left,resizeactive,-20 0"
      "SUPER_CTRL,right,resizeactive,20 0"
      "SUPER_CTRL,up,resizeactive,0 -20"
      "SUPER_CTRL,down,resizeactive,0 20"

      # Move Active (Floating Only)
      "SUPER_ALT,left,moveactive,-20 0"
      "SUPER_ALT,right,moveactive,20 0"
      "SUPER_ALT,up,moveactive,0 -20"
      "SUPER_ALT,down,moveactive,0 20"

      # Switch between windows
      "SUPER,Tab,cyclenext,"
      "SUPER,Tab,bringactivetotop,"

      # Workspaces
      "SUPER,1,workspace,1"
      "SUPER,2,workspace,2"
      "SUPER,3,workspace,3"
      "SUPER,4,workspace,4"
      "SUPER,5,workspace,5"
      "SUPER,6,workspace,6"
      "SUPER,7,workspace,7"
      "SUPER,8,workspace,8"

      # Send to Workspaces
      "SUPER_SHIFT,1,movetoworkspace,1"
      "SUPER_SHIFT,2,movetoworkspace,2"
      "SUPER_SHIFT,3,movetoworkspace,3"
      "SUPER_SHIFT,4,movetoworkspace,4"
      "SUPER_SHIFT,5,movetoworkspace,5"
      "SUPER_SHIFT,6,movetoworkspace,6"
      "SUPER_SHIFT,7,movetoworkspace,7"
      "SUPER_SHIFT,8,movetoworkspace,8"
    ];

    # Mouse Buttons
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
