{ ... }:
{
  my.services = {
    ssh.enable = true;
    storage = true;
    thermald = true;
    tailscale = true;
  };

  my.features = {
    nix-helper.enable = true;
    podman.enable = true;
  };
}
