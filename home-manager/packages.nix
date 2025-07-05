{ config, pkgs, ... }:

let
  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { config.allowUnfree = true; };
in
{
  home.packages = [
    # Browsers
    pkgs.brave

    # Communication
    unstable.discord

    # Cursors/Themes
    pkgs.catppuccin-cursors.mochaLavender

    # Development
    pkgs.gh
    pkgs.jetbrains.rust-rover
    pkgs.jetbrains.webstorm
    pkgs.nodejs_24
    pkgs.rustc
    pkgs.rustup
    unstable.vscode
    pkgs.gmp

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
    pkgs.qalculate-gtk
    pkgs.file-roller
  ];
}
