{ ... }:
{
  imports = [
    # Base independent modules
    ./paths.nix
    ./services.nix
    ./groups.nix
    ./theme/core.nix
    ./overlays
    ./channels
    # Aggregated collections
    ./users
    ./system
    ./features
    # Host-specific modules
    ./hosts/NixBook/default.nix
  ];
}
