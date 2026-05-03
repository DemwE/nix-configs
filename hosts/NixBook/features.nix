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
    nvidia.runtimePowerManagement = true;
    nvidia.prime.enable = true;

    atuin.enable = true;
    syncthing.enable = true;
    docker.enable = false;
    podman.enable = true;
    flatpak.enable = true;
    qemu.enable = false;
    polkit.enable = true;
    gdm.enable = true;
    gnome.enable = true;
    fprintd.enable = true;
    iioSensorProxy.enable = false;
    steam.enable = true;
    supergfxd.enable = true;
    ollama.enable = false;
    postgres.enable = false;
    wireshark.enable = true;
  };
}
