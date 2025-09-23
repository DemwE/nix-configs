{ ... }:
{
  imports = [
    # Base independent modules
    ./nvidia.nix
    ./packages.nix
    ./services.nix
    ./groups.nix
    ./theme/core.nix
      ./channels                  # External channels (home-manager import)
    # Aggregated collections
    ./users
    ./system
    ./features
  ];
}
