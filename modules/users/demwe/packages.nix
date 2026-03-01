{ pkgs, ... }:
{
  # Nix packages
  users.users.demwe.packages = with pkgs; [
    # Browsers
    brave

    # Communication
    # unstable.discord  # installed via Flatpak (see home/demwe/flatpak.nix)

    # Development
    gh
    unstable.vscode
    nixfmt-rfc-style
    # custom.rust-rover
    # custom.webstorm
    # custom.pycharm
    # custom.clion

    # Creativity
    # unstable.davinci-resolve
    # unstable.obs-studio
    # unstable.krita

    # Games
    # unstable.prismlauncher
    # unstable.vintagestory

    # Media
    mpv

    # Utilities
    ffmpeg-full
    gparted
    # s-tui
    # stress
    collision
    apostrophe
    # winbox4
    custom.compress
    custom.decompress
    dust

    # Toolchains
    custom.toolchain-rust
    # custom.toolchain-nodejs
    custom.toolchain-python
    # custom.toolchain-cpp

    # Java
    # custom.java25
    # custom.java25.versioned
    # custom.java21.versioned
    # custom.java17.versioned
    # custom.java11.versioned
    # custom.java8.versioned
  ];

  # Flatpak packges
  home-manager.users.demwe.services.flatpak.packages = [
    "com.discordapp.Discord"
  ];
}
