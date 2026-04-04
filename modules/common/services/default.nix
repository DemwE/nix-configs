{ lib, config, pkgs,... }:
{
  options.my.services = {
    ssh = lib.mkEnableOption "Enable SSH server";
    printing = lib.mkEnableOption "Enable printing support (CUPS)";
    storage = lib.mkEnableOption "Enable storage services (udisks2, gvfs)";
    firewall = lib.mkEnableOption "Enable firewall";
    syncthing = lib.mkEnableOption "Enable Syncthing";
  };

  config = lib.mkMerge [
    (lib.mkIf config.my.services.ssh {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = true;
        };
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

    (lib.mkIf config.my.services.firewall {
      networking.firewall.enable = true;
    })

    (lib.mkIf config.my.services.syncthing {
      services.syncthing = {
        enable = true;
        package = pkgs.unstable.syncthing;
        user = "demwe";
        group = "users";
        configDir = "/home/demwe/.local/state/syncthing";
      };
    })
  ];
}
