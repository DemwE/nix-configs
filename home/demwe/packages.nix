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

    # Games
    pkgs.unstable.prismlauncher
    pkgs.unstable.vintagestory

    # Media
    pkgs.mpv

    # Utilities
    # dunst, kitty, rofi-wayland, waybar are managed by programs.* in HM
    pkgs.ffmpeg-full
    pkgs.gparted
    pkgs.s-tui
    pkgs.stress
    pkgs.collision
    pkgs.apostrophe
    pkgs.winbox4
    pkgs.cpufetch
    pkgs.gpufetch

    # Rust toolchain (includes rustfmt, clippy, and cargo)
    pkgs.rustup
    pkgs.rustc
    pkgs.gcc
    pkgs.gnumake
  ];
}
