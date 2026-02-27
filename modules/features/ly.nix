{ lib, config, pkgs, ... }:
{
  options.my.features.ly.enable = lib.mkEnableOption "Enable ly display manager";
  config = lib.mkIf config.my.features.ly.enable {
    services.displayManager.ly.enable = true;
    services.displayManager.ly.package = pkgs.unstable.ly;
  };
}