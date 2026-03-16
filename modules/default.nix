{ ... }:
{
  imports = [
    # Base independent modules
    ./paths.nix
    ./groups.nix
    ./theme/core.nix
    ./overlays

    # Common modules (available for all hosts)
    ./common/boot/default.nix
    ./common/networking/default.nix
    ./common/services/default.nix
    ./common/packages/default.nix

    # Aggregated collections
    ./users
    ./system
    ./features

    # Host-specific modules
    ./hosts/NixBook
    ./hosts/DemwEPC
  ];
}
