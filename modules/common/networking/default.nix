{
  lib,
  pkgs,
  pkgs-unstable ? null,
  config,
  ...
}:
{
  options.my.networking = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "NixOS";
      description = "System hostname";
    };
    openvpn = lib.mkEnableOption "Enable OpenVPN plugin for NetworkManager";

    firewall = {
      enable = lib.mkEnableOption "Enable firewall";

      allowedTCPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = "TCP ports to open in the firewall.";
      };

      allowedTCPPortRanges = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            from = lib.mkOption {
              type = lib.types.port;
              description = "Start of the TCP port range.";
            };

            to = lib.mkOption {
              type = lib.types.port;
              description = "End of the TCP port range.";
            };
          };
        });
        default = [ ];
        description = "TCP port ranges to open in the firewall.";
      };

      allowedUDPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = "UDP ports to open in the firewall.";
      };

      allowedUDPPortRanges = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            from = lib.mkOption {
              type = lib.types.port;
              description = "Start of the UDP port range.";
            };

            to = lib.mkOption {
              type = lib.types.port;
              description = "End of the UDP port range.";
            };
          };
        });
        default = [ ];
        description = "UDP port ranges to open in the firewall.";
      };
    };
  };

  config = {
    networking.hostName = config.my.networking.hostname;
    networking.networkmanager.enable = true;

    networking.networkmanager.plugins = lib.mkIf config.my.networking.openvpn [
      (
        if pkgs-unstable != null then pkgs-unstable.networkmanager-openvpn else pkgs.networkmanager-openvpn
      )
    ];

    networking.firewall = lib.mkIf config.my.networking.firewall.enable {
      enable = true;
      allowedTCPPorts = config.my.networking.firewall.allowedTCPPorts;
      allowedTCPPortRanges = config.my.networking.firewall.allowedTCPPortRanges;
      allowedUDPPorts = config.my.networking.firewall.allowedUDPPorts;
      allowedUDPPortRanges = config.my.networking.firewall.allowedUDPPortRanges;
    };

    # Custom hosts entries:
    networking.hosts = {
      "127.0.0.1" = [
        "lh.me"
      ];
    };
  };
}
