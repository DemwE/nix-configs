{
  pkgs-unstable ? null,
  ...
}:
{
  imports = [
    ../../common/boot/default.nix
    ../../common/networking/default.nix
    ../../common/services/default.nix
    ../../common/packages/default.nix
    ./boot.nix
    ./networking.nix
    ./features.nix
  ];

  my.host = {
    name = "NixBook";
    stateVersion = "25.11";
  };
}
