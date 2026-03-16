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
  };

  config = {
    networking.hostName = config.my.networking.hostname;
    networking.networkmanager.enable = true;

    networking.networkmanager.plugins = lib.mkIf config.my.networking.openvpn [
      (
        if pkgs-unstable != null then pkgs-unstable.networkmanager-openvpn else pkgs.networkmanager-openvpn
      )
    ];
  };
}
