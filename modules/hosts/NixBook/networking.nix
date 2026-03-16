{
  pkgs-unstable ? null,
  ...
}:
{
  my.networking = {
    enable = true;
    hostname = "NixBook";
    openvpn = true;
  };
}
