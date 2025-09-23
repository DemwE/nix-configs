{ ... }:
{
  # Nix settings (GC + optimizations)
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Could add substituters / experimental features here later
}
