{ config, pkgs, ... }:
{
  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    # Browsers
    brave

    # Development
    nixfmt
    unstable.gitkraken
    custom.rust-rover
    custom.webstorm
    custom.pycharm
    custom.clion
    custom.rider
    custom.idea
    custom.datagrip
    unstable.vscode
    unstable.unityhub
    unstable.opencode
    unstable.zed-editor
    unstable.arduino-ide
    podman-desktop

    # Creativity
    unstable.gimp
    unstable.blender
    unstable.obs-studio
    unstable.krita
    unstable.aseprite
    unstable.freecad
    unstable.audacity
    unstable.reaper

    # Games
    unstable.prismlauncher
    # custom.vintage-story
    unstable.openrct2

    # Media
    mpv
    gapless
    ffmpeg-full

    # Utilities
    gparted
    collision
    apostrophe
    unstable.winbox4
    custom.battery-watch
    custom.battery-info
    custom.nvidia-offload
    dust
    croc
    powertop
    unstable.atlas
    unstable.gamescope
    speedtest-cli
    custom.ventoy
    foliate
    varia
    unstable.crosspipe
    custom.eartag
    unstable.cavalier
    file-roller
    alsa-utils

    # Java
    custom.java25.versioned
    custom.java21.versioned
    custom.java17.versioned
    custom.java11.versioned
    custom.java8.versioned

    # Typst
    unstable.typesetter
    unstable.typst
    unstable.tinymist

    # Language tools
    unstable.wordbook
    unstable.dialect
    unstable.eloquent
    unstable.hunspellDicts.en_US-large
    unstable.hunspellDicts.pl_PL
    wike

    # Office
    unstable.onlyoffice-desktopeditors

    # Other
    gnome-graphs
    nucleus
    qbittorrent
  ];

  # Flatpak packages
  services.flatpak.packages = [
    "com.discordapp.Discord"
  ];
}
