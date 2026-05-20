{ lib, config, ... }:
{
  options.my.services = {
    ssh = lib.mkEnableOption "Enable SSH server";
    printing = lib.mkEnableOption "Enable printing support (CUPS)";
    storage = lib.mkEnableOption "Enable storage services (udisks2, gvfs)";
    openrgb = lib.mkEnableOption "Enable OpenRGB daemon";
  };

  config = lib.mkMerge [
    (lib.mkIf config.my.services.ssh {
      services.openssh = {
        enable = true;
        hostKeys = [
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
  ];
}
