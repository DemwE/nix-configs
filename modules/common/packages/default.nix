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
        usbutils
        pciutils
        net-tools
        eza
        fzf
        nix-index
        custom.switch
        custom.update-lock
        custom.switch-check
      ]
    );
  };
}
