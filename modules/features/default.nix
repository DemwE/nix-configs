{ ... }:
{
  imports = [
    ./nvidia.nix
    ./docker.nix
    ./postgres.nix
    ./flatpak.nix
    ./qemu.nix
    ./polkit.nix
    ./gdm.nix
    ./gnome.nix
    ./fprintd.nix
    ./howdy.nix
    ./iio-sensor-proxy.nix
    ./steam.nix
    ./supergfxd.nix
    ./ollama.nix
  ];
}
