{ ... }:
{
  my.networking = {
    hostname = "N1";
    openvpn = true;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [

      ];
      allowedUDPPortRanges = [

      ];
    };
  };
}
