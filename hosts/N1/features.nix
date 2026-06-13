{ ... }:
{
  my.services = {
    ssh.enable = true;
    storage.enable = true;
    thermald.enable = true;
    tailscale.enable = true;
  };

  my.packages.server.enable = true;

  my.features = {
    nix-helper.enable = true;
    podman.enable = true;
  };
}
