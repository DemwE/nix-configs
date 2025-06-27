{ config, lib, ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Exit";
        keybind = "e";
      }
    ];
    style = ''
      /* Catppuccin Mocha Color Palette */
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;
      @define-color text #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;
      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;
      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color sapphire #74c7ec;
      @define-color sky #89dceb;
      @define-color teal #94e2d5;
      @define-color green #a6e3a1;
      @define-color yellow #f9e2af;
      @define-color peach #fab387;
      @define-color maroon #eba0ac;
      @define-color red #f38ba8;
      @define-color mauve #cba6f7;
      @define-color pink #f5c2e7;
      @define-color flamingo #f2cdcd;
      @define-color rosewater #f5e0dc;

      * {
          background-image: none;
          font-family: "Inter", "JetBrainsMono Nerd Font", monospace;
          font-size: 14px;
      }

      window {
          background-color: alpha(@crust, 0.95);
      }

      button {
          color: @text;
          font-size: 18px;
          font-weight: 500;
          background-color: @surface0;
          border: 2px solid @surface1;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 40px;
          border-radius: 20px;
          margin: 20px;
          padding: 40px;
          min-width: 90px;
          min-height: 80px;
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
          transition: all 200ms ease-in-out;
      }

      button:focus,
      button:active {
          background-color: @surface1;
          outline: none;
          box-shadow: 0 6px 16px rgba(0, 0, 0, 0.4);
      }

      button:hover {
          background-color: @surface1;
          border-color: @surface2;
          box-shadow: 0 6px 16px rgba(0, 0, 0, 0.4);
      }

      /* Lock button */
      #lock {
          background-image: image(url("${toString .././config-resources/wlogout/lock.png}"));
          border-color: @yellow;
      }

      #lock:hover,
      #lock:focus,
      #lock:active {
          border-color: @yellow;
          color: @yellow;
          box-shadow: 0 6px 20px alpha(@yellow, 0.3);
          background-color: alpha(@yellow, 0.05);
      }

      /* Logout button */
      #logout {
          background-image: image(url("${toString .././config-resources/wlogout/logout.png}"));
          border-color: @blue;
      }

      #logout:hover,
      #logout:focus,
      #logout:active {
          border-color: @blue;
          color: @blue;
          box-shadow: 0 6px 20px alpha(@blue, 0.3);
          background-color: alpha(@blue, 0.05);
      }

      /* Shutdown button */
      #shutdown {
          background-image: image(url("${toString .././config-resources/wlogout/shutdown.png}"));
          border-color: @red;
      }

      #shutdown:hover,
      #shutdown:focus,
      #shutdown:active {
          border-color: @red;
          color: @red;
          box-shadow: 0 6px 20px alpha(@red, 0.3);
          background-color: alpha(@red, 0.05);
      }

      /* Reboot button */
      #reboot {
          background-image: image(url("${toString .././config-resources/wlogout/reboot.png}"));
          border-color: @green;
      }

      #reboot:hover,
      #reboot:focus,
      #reboot:active {
          border-color: @green;
          color: @green;
          box-shadow: 0 6px 20px alpha(@green, 0.3);
          background-color: alpha(@green, 0.05);
      }
    '';
  };
}