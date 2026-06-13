{ ... }:
{
  my.services = {
    ssh.enable = true;
    storage.enable = true;
    thermald.enable = true;
    tailscale.enable = true;
  };

  my.features = {
    nix-helper.enable = true;
    podman.enable = true;
  };
}
