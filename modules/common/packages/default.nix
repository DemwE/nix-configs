{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = {
    environment.systemPackages = (
      with pkgs;
      [
        neovim
        zsh
        fastfetch
        btop
        duf
        tree
        wget
        git
        yazi
        bat
      ]
    );
  };
}
