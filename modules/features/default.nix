{ ... }:
{
  # Aggregated feature modules. Importing this file pulls in all feature
  # option definitions; actual activation is still controlled via
  # my.features.<name>.enable in profiles or host configs.
  imports = [
    ./nvidia.nix
    ./wifi.nix
    ./docker.nix
    ./qemu.nix
    ./polkit.nix
    ./hyprland.nix
    ./sddm.nix
    ./bluetooth.nix
  ];
}
