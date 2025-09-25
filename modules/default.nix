{ ... }:
{
  imports = [
    # Base independent modules
    ./nvidia.nix
    ./paths.nix
    ./desktop.nix
    ./services.nix
    ./groups.nix
    ./theme/core.nix
    ./overlays # Central overlays (e.g., nixos-unstable)
    ./channels # External channels (home-manager import)
    # Aggregated collections
    ./users
    ./system
    ./features
  ];
}
