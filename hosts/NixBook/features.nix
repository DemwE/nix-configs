{ ... }:
{
  my.services = {
    ssh = {
      enable = true;
      preservation.enable = true;
    };
    printing.enable = true;
    storage.enable = true;
    thermald.enable = true;
    tailscale.enable = true;
    fwupd.enable = true;
  };

  my.features = {
    nvidia.enable = true;
    nvidia.runtimePowerManagement = true;
    nvidia.prime.enable = true;

    tlp.enable = true;

    syncthing.enable = true;
    docker.enable = true;
    nix-helper.enable = true;
    podman.enable = true;
    flatpak.enable = true;
    polkit.enable = true;
    gdm.enable = true;
    gnome.enable = true;
    fprintd.enable = true;
    steam.enable = true;
    obs.enable = true;
    supergfxd.enable = true;
    wireshark.enable = true;
    ld.enable = true;

    incus = {
      enable = true;
      ui.enable = true;
    };
  };
}
