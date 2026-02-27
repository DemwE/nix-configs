{ config, pkgs, ... }:
{
  home.packages = [
    # Browsers
    pkgs.brave

    # Communication
    pkgs.unstable.discord

    # Development
    pkgs.gh
    pkgs.unstable.vscode
    pkgs.nixfmt-rfc-style
    pkgs.custom.rust-rover
    pkgs.custom.webstorm
    pkgs.custom.clion

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
    pkgs.custom.compress
    pkgs.custom.decompress

    # Toolchains
    pkgs.custom.toolchain-rust
    pkgs.custom.toolchain-cpp
    pkgs.custom.toolchain-nodejs
  ];
}
