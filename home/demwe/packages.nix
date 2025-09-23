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
    pkgs.rustc
    pkgs.rustup
    unstable.vscode
    pkgs.nixfmt-rfc-style

    # File Manager
    pkgs.nemo-with-extensions
    pkgs.nemo-fileroller


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
    pkgs.ffmpeg-full
    pkgs.gnome-disk-utility
    pkgs.gparted
    pkgs.s-tui
    pkgs.stress
  ];
}
