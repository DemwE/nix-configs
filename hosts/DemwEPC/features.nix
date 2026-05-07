{ ... }:
{
  my.services = {
    ssh = true;
    printing = true;
    storage = true;
    firewall = true;
  };

  my.features = {
    nvidia.enable = true;
    nvidia.runtimePowerManagement = false;
    nvidia.prime.enable = false;

    syncthing.enable = true;
    docker.enable = false;
    podman.enable = true;
    nix-helper.enable = true;
    flatpak.enable = true;
    qemu.enable = false;
    polkit.enable = true;
    gdm.enable = true;
    gnome.enable = true;
    fprintd.enable = false;
    iioSensorProxy.enable = false;
    steam.enable = true;
    supergfxd.enable = false;
    ollama.enable = true;
    postgres.enable = false;
    wireshark.enable = true;
  };
}
