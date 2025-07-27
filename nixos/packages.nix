{ pkgs, ... }:
{ 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.neovim
    pkgs.zsh
    pkgs.fastfetch
    pkgs.wget
    pkgs.git
    pkgs.dconf
    pkgs.xwayland
    pkgs.home-manager
    pkgs.hyprlock
    pkgs.nixfmt-rfc-style
    pkgs.yazi
    pkgs.bat
    pkgs.tree
    pkgs.btop
    pkgs.duf
    pkgs.gnome-keyring
    pkgs.qemu
    pkgs.virt-manager
  ];
}
