{ pkgs, ... }:
{
  # Nix packages
  users.users.demwe.packages = with pkgs; [
    # Browsers
    brave

    # Communication
    # unstable.discord

    # Development
    gh
    unstable.vscode
    nixfmt-rfc-style
    custom.rust-rover
    custom.webstorm
    custom.pycharm
    custom.clion
    custom.rider
    custom.idea
    unstable.jetbrains.datagrip

    # Creativity
    # davinci-resolve
    unstable.obs-studio
    unstable.krita

    # Games
    unstable.prismlauncher
    unstable.vintagestory

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
    killall
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
    unstable.onlyoffice-desktopeditors
    unstable.gamescope
    unstable.bottles
  ];

  # Flatpak packges
  home-manager.users.demwe.services.flatpak.packages = [
    "com.discordapp.Discord"
  ];
}
