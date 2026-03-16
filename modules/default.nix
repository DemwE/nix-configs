{ ... }:
{
  imports = [
    # Base independent modules
    ./paths.nix
    ./groups.nix
    ./theme/core.nix
    ./overlays
    # Aggregated collections
    ./users
    ./system
    ./features
    # Host-specific modules
    ./hosts/NixBook/default.nix
  ];
}
