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
    pkgs.discord
    pkgs.gh
  ];
}
