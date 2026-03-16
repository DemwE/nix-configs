{ pkgs, pkgs-unstable, ... }:
{
  # Nix packages
  users.users.demwe.packages = with pkgs; [
    # Browsers
    brave

    # Communication
    # pkgs-unstable.discord

    # Development
    gh
    pkgs-unstable.vscode
    nixfmt-rfc-style
    custom.rust-rover
    custom.webstorm
    custom.pycharm
    custom.clion
    custom.rider
    custom.idea
    custom.datagrip
    pkgs-unstable.opencode

    # Creativity
    # davinci-resolve
    pkgs-unstable.obs-studio
    pkgs-unstable.krita
    pkgs-unstable.gimp
    pkgs-unstable.blender
    pkgs-unstable.aseprite

    # Games
    pkgs-unstable.prismlauncher
    pkgs-unstable.vintagestory

    # Media
    mpv

    # Utilities
    ffmpeg-full
    gparted
    # s-tui
    # stress
    collision
    apostrophe
    winbox4
    custom.compress
    custom.decompress
    custom.battery-watch
    custom.battery-info
    custom.nvidia-offload
    dust
    toybox
    powertop

    # Toolchains — available via ~/.toolchains/*/bin (home/demwe/toolchains.nix)

    # Java
    custom.java25.versioned
    custom.java21.versioned
    custom.java17.versioned
    custom.java11.versioned
    custom.java8.versioned

    # Other
    gnome-decoder
    unityhub
    pkgs-unstable.onlyoffice-desktopeditors
    pkgs-unstable.gamescope
    pkgs-unstable.bottles
    pkgs-unstable.eloquent

    # Typst
    pkgs-unstable.typesetter
    pkgs-unstable.typst
    pkgs-unstable.tinymist

    # Grammar
    pkgs-unstable.wordbook
    pkgs-unstable.dialect
    pkgs-unstable.hunspellDicts.en_US-large
    pkgs-unstable.hunspellDicts.pl_PL
  ];

  # Flatpak packges
  home-manager.users.demwe.services.flatpak.packages = [
    "com.discordapp.Discord"
  ];
}
