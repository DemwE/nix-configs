{ ... }:
{
  imports = [
    ./nvidia.nix
    ./docker.nix
    ./postgres.nix
    ./atuin.nix
    ./syncthing.nix
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
    ./wireshark.nix
  ];
}
