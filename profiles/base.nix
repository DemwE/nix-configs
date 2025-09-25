{ ... }:
{
  # Base profile reserved for future shared defaults.
  imports = [
    "../modules" # Aggregated modules (default.nix)
  ];

  # Common packages for all systems
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
