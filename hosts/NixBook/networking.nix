{ ... }:
{
  my.networking = {
    hostname = "NixBook";
    openvpn = true;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        # Development ports
        { from = 7000; to = 7100; }
        { from = 3000; to = 3100; }
      ];
    };
  };
}
