{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Core editor & shell tools
    pkgs.neovim pkgs.zsh pkgs.fastfetch pkgs.wget pkgs.git
    # Desktop/system utilities (not feature‑specific)
    pkgs.dconf pkgs.yazi pkgs.bat pkgs.tree pkgs.btop pkgs.duf pkgs.gnome-keyring
  ];
}
