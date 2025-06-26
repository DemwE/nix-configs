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
    pkgs.catppuccin-cursors.mochaLavender
    pkgs.magnetic-catppuccin-gtk
    pkgs.discord
    pkgs.gh
  ];
}
