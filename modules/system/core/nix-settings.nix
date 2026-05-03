{ ... }:
{
  # Core Nix maintenance
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  # system.copySystemConfiguration = true; # Not supported with flakes
}
