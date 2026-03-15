{ ... }:
{
  imports = [
    # Base independent modules
    ./paths.nix
    ./services.nix
    ./groups.nix
    ./theme/core.nix
    ./overlays # Central overlays (e.g., nixos-unstable)
    # Aggregated collections
    ./users
    ./system
    ./features
  ];
}
