{
  lib,
  pkgs,
  pkgs-unstable ? null,
  config,
  ...
}:
{
  options.my.boot = {
    kernel = lib.mkOption {
      type = lib.types.enum [
        "stable"
        "unstable"
      ];
      default = "unstable";
      description = "Kernel version to use";
    };
  };

  config = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 8;

    boot.kernelPackages =
      if config.my.boot.kernel == "unstable" && pkgs-unstable != null then
        pkgs-unstable.linuxPackages
      else
        pkgs.linuxPackages;
  };
}
