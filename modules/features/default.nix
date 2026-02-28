{ ... }:
{
  # Aggregated feature modules. Importing this file pulls in all feature
  # option definitions; actual activation is still controlled via
  # my.features.<name>.enable in profiles or host configs.
  imports = [
    ./nvidia.nix
    ./docker.nix
    ./flatpak.nix
    ./qemu.nix
    ./polkit.nix
    ./gdm.nix
    ./gnome.nix
  ];
}
