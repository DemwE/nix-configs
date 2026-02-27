{ config, pkgs, ... }:
{
  home.packages = [
    # Browsers
    pkgs.brave

    # Communication
    pkgs.unstable.discord

    # Development
    pkgs.gh
    pkgs.unstable.jetbrains.rust-rover
    pkgs.unstable.jetbrains.webstorm
    pkgs.unstable.jetbrains.clion
    pkgs.unstable.vscode
    pkgs.nixfmt-rfc-style

    # Creativity
    # pkgs.unstable.davinci-resolve
    # pkgs.unstable.obs-studio
    # pkgs.unstable.krita

    # File Manager
    pkgs.nemo-with-extensions
    pkgs.nemo-fileroller

    # Games
    pkgs.prismlauncher

    # Media
    pkgs.mpv

    # Utilities
    # dunst, kitty, rofi-wayland, waybar are managed by programs.* in HM
    pkgs.pavucontrol
    pkgs.qalculate-gtk
    pkgs.file-roller
    pkgs.ffmpeg-full
    pkgs.gnome-disk-utility
    pkgs.gparted
    pkgs.s-tui
    pkgs.stress
    pkgs.gnome-text-editor
    pkgs.papers
    pkgs.decibels
    pkgs.loupe
    pkgs.collision
    pkgs.apostrophe
    pkgs.winbox4

    # Rust toolchain (includes rustfmt, clippy, and cargo)
    pkgs.rustup
    pkgs.rustc
    pkgs.gcc
    pkgs.gnumake
  ];
}
