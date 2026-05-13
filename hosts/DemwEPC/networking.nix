{ ... }:
{
  my.networking = {
    hostname = "DemwEPC";
    openvpn = true;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        { from = 7000; to = 7100; }
        { from = 3000; to = 3100; }
      ];
    };
  };
}
