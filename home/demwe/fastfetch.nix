{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
        source = "${config.my.paths.resources}/fastfetch-image";
        color = {
          "1" = "bright_magenta";
        };
      };

      display = {
        color = "bright_magenta";
      };

      modules = [
        "title"
        "separator"
        "os"
        "kernel"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "localip"
        "break"
        "colors"
      ];
    };
  };
}
