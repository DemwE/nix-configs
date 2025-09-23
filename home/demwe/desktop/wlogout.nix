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
    style = let p = config.my.theme.palette; in ''
      /* Catppuccin palette (central) */
      @define-color base ${p.base};
      @define-color mantle ${p.mantle};
      @define-color crust ${p.crust};
      @define-color text ${p.text};
      @define-color subtext0 ${p.subtext0};
      @define-color subtext1 ${p.subtext1};
      @define-color surface0 ${p.surface0};
      @define-color surface1 ${p.surface1};
      @define-color surface2 ${p.surface2};
      @define-color overlay0 ${p.overlay0};
      @define-color overlay1 ${p.overlay1};
      @define-color overlay2 ${p.overlay2};
      @define-color blue ${p.blue};
      @define-color lavender ${p.lavender};
      @define-color sapphire ${p.sapphire};
      @define-color sky ${p.sky};
      @define-color teal ${p.teal};
      @define-color green ${p.green};
      @define-color yellow ${p.yellow};
      @define-color peach ${p.peach};
      @define-color maroon ${p.maroon};
      @define-color red ${p.red};
      @define-color mauve ${p.mauve};
      @define-color pink ${p.pink};
      @define-color flamingo ${p.flamingo};
      @define-color rosewater ${p.rosewater};

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
      background-image: image(url("${config.my.paths.resources}/wlogout/lock.png"));
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
      background-image: image(url("${config.my.paths.resources}/wlogout/logout.png"));
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
      background-image: image(url("${config.my.paths.resources}/wlogout/shutdown.png"));
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
      background-image: image(url("${config.my.paths.resources}/wlogout/reboot.png"));
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