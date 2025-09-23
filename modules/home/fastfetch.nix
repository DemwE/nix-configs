{ my, ... }:
let
  p = my.theme.palette;
  accent = my.theme.accent;
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "ascii";
        source = ''
          ${p.${accent}}███${p.surface2}██${p.${accent}}███  ${p.text}Catppuccin
          ${p.${accent}}  ██${p.surface2}██  ${p.text}NixOS on Wayland
          ${p.${accent}}  ██${p.surface2}██  ${p.text}${my.theme.flavor}
        '';
      };
      display = {
        color = accent;
        separator = "  ";
      };
      modules = [
        "title"
        "os"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "terminal"
        "wm"
        "wmtheme"
        "display"
        "memory"
        "disk"
        "cpu"
        "gpu"
        "localip"
        "battery"
        "colors"
      ];
    };
  };
}
