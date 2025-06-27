{ pkgs, ... }:
{
  home.packages = [
    # Browsers
    pkgs.brave

    # Communication
    pkgs.discord

    # Cursors/Themes
    pkgs.catppuccin-cursors.mochaLavender

    # Development
    pkgs.gh
    pkgs.jetbrains.rust-rover
    pkgs.jetbrains.webstorm
    pkgs.nodejs_24
    pkgs.rustc
    pkgs.vscode

    # File Manager
    pkgs.xfce.thunar
    pkgs.xfce.thunar-archive-plugin
    pkgs.xfce.thunar-vcs-plugin
    pkgs.xfce.thunar-volman

    # Games
    pkgs.prismlauncher

    # Media
    pkgs.mpv

    # Utilities
    pkgs.dunst
    pkgs.grim
    pkgs.kitty
    pkgs.pavucontrol
    pkgs.rofi-wayland
    pkgs.slurp
    pkgs.swappy
    pkgs.waybar
  ];
}
