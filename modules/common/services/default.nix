{ lib, config, ... }:
{
  options.my.services = {
    ssh = {
      enable = lib.mkEnableOption "Enable SSH server";
      preservation.enable = lib.mkEnableOption "Preserve SSH host keys across system rebuilds";
    }
    printing = lib.mkEnableOption "Enable printing support (CUPS)";
    storage = lib.mkEnableOption "Enable storage services (udisks2, gvfs)";
    openrgb = lib.mkEnableOption "Enable OpenRGB daemon";
    thermald = lib.mkEnableOption "Enable Intel Themal Daemon (thermald)";
    tailscale = lib.mkEnableOption "Enable Tailscale VPN client";
  };

  config = lib.mkMerge [
    (lib.mkIf config.my.services.ssh {
      services.openssh = {
        enable = true;
        hostKeys = lib.mkIf config.my.services.ssh.preservation.enable [
          {
            path = "/persist/ssh/ssh_host_ed25519_key";
            type = "ed25519";
          }
          {
            path = "/persist/ssh/ssh_host_rsa_key";
            type = "rsa";
          }
        ];
      };
    })

    (lib.mkIf config.my.services.printing {
      services.printing.enable = true;
    })

    (lib.mkIf config.my.services.storage {
      services.udisks2.enable = true;
      services.udisks2.mountOnMedia = true;
      services.gvfs.enable = true;
      services.tumbler.enable = true;
    })

    (lib.mkIf config.my.services.openrgb {
      services.hardware.openrgb.enable = true;
    })

    (lib.mkIf config.my.services.thermald {
      services.thermald.enable = true;
    })

    (lib.mkIf config.my.services.tailscale {
      services.tailscale.enable = true;
    })
  ];
}
