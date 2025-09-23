{ my, lib, ... }:
let p = my.theme.palette; accent = my.theme.accent; in lib.mkIf my.features.hyprland.enable {
  xdg.configFile."kitty/catppuccin-theme.conf".text = ''
    background ${p.base}
    foreground ${p.text}
    selection_background ${p.surface2}
    cursor ${p.${accent} or p.lavender}
    color0  ${p.crust}
    color8  ${p.surface1}
    color1  ${p.red}
    color9  ${p.red}
    color2  ${p.green}
    color10 ${p.green}
    color3  ${p.yellow}
    color11 ${p.yellow}
    color4  ${p.blue}
    color12 ${p.blue}
    color5  ${p.mauve}
    color13 ${p.mauve}
    color6  ${p.sapphire}
    color14 ${p.sapphire}
    color7  ${p.subtext1}
    color15 ${p.text}
  '';
  programs.kitty = {
    enable = true;
    themeFile = "catppuccin-theme.conf";
    font = { name = my.theme.font.terminal; size = 11; };
    settings = { window_padding_width = 6; }; 
  };
}
