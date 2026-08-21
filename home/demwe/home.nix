{ config, pkgs, ... }:

{
  imports = [
    ./home-configuration.nix
    ./session-vars.nix
    ./dconf.nix
    ./git.nix
    ./zsh.nix
    ./atuin.nix
    ./fastfetch.nix
    ./yazi.nix
    ./btop.nix
    ./neovim.nix
    ./gnome.nix
    ./java.nix
    ./python.nix
    ./nodejs.nix
    ./cpp.nix
    ./toolchains.nix
    ./ides.nix
    ./beets.nix
    ./eza.nix
    ./oh-my-posh.nix
    ./direnv.nix
    ./templates.nix
    ./packages.nix
    ./kitty.nix
  ];

  # systemd.user.startServices = "sd-switch";

  # home.sessionVariables = {
  #   XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
  # };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
