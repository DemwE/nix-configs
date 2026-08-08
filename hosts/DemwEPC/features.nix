{ ... }:
{
  my.audio.quality = "high";

  my.services = {
    ssh.enable = true;
    printing.enable = true;
    storage.enable = true;
    openrgb.enable = true;
  };

  my.features = {
    nvidia.enable = true;

    syncthing.enable = true;
    docker.enable = true;
    podman.enable = true;
    nix-helper.enable = true;
    flatpak.enable = true;
    qemu.enable = true;
    polkit.enable = true;
    gdm.enable = true;
    gnome.enable = true;
    steam.enable = true;
    obs.enable = true;
    wireshark.enable = true;
    ld.enable = true;

    incus = {
      enable = true;
      ui.enable = true;
    };
  };
}
