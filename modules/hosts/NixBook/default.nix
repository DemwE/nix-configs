{
  pkgs-unstable ? null,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../common/boot/default.nix
    ../../common/networking/default.nix
    ../../common/services/default.nix
    ../../common/packages/default.nix
    ./boot.nix
    ./networking.nix
    ./features.nix
  ];
}
