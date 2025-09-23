{ pkgs, ... }:
{
  # Base system packages (host & feature independent)
  environment.systemPackages = with pkgs; [
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
  ];
}
