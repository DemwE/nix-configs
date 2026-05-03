{ ... }:
{
  imports = [
    ./graphics/nvidia.nix
    ./containers/docker.nix
    ./containers/podman.nix
    ./database/postgres.nix
    ./tools/atuin.nix
    ./tools/syncthing.nix
    ./desktop/flatpak.nix
    ./virtualization/qemu.nix
    ./security/polkit.nix
    ./desktop/gdm.nix
    ./desktop/gnome.nix
    ./desktop/fprintd.nix
    ./desktop/howdy.nix
    ./desktop/iio-sensor-proxy.nix
    ./desktop/steam.nix
    ./graphics/supergfxd.nix
    ./tools/ollama.nix
    ./tools/wireshark.nix
  ];
}
