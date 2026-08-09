{ config, pkgs, ... }:
{
  # Hyprland-related user tools (clipboard + screenshots)
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    grim # used for area selection screenshot
    slurp # region selection helper for grim
    jq # for parsing hyprctl JSON in binds
    swappy # used by grimblast edit
    eog # image viewer
  ];

  # Clipboard history daemon (stores selections via wl-paste -> cliphist)
  systemd.user.services.cliphist = {
    Unit = {
      Description = "Cliphist clipboard history watcher";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
      RestartSec = 1;
      Slice = "app.slice";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      require("config.config")
      require("config.windows")
      require("config.binds")
      require("config.rules")
    '';
  };

  xdg.configFile."hypr/config".source = ./lua;
}
