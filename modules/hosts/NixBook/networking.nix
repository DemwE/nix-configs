{
  pkgs-unstable ? null,
  ...
}:
{
  my.networking = {
    hostname = "NixBook";
    openvpn = true;
  };
}
