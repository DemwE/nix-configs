{ ... }:
{
  imports = [
    # Base independent modules
    ./nvidia.nix
    ./paths.nix
    ./packages.nix
    ./services.nix
    ./groups.nix
    ./theme/core.nix
    ./channels
    # Aggregated collections
    ./users
    ./system
    ./features
  ];
}
