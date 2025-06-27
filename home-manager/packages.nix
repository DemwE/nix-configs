{ pkgs, ... }:
{ 
  home.packages = [
    pkgs.mpv
    pkgs.brave
    pkgs.kitty
    pkgs.vscode
    pkgs.dunst
    pkgs.waybar
    pkgs.rofi-wayland
    pkgs.xfce.thunar
    pkgs.xfce.thunar-volman
    pkgs.xfce.thunar-vcs-plugin
    pkgs.xfce.thunar-archive-plugin
    pkgs.catppuccin-cursors.mochaLavender
    pkgs.discord
    pkgs.gh
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    pkgs.pavucontrol
  ];
}
