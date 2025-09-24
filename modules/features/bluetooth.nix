{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.bluetooth;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.bluetooth.enable = mkEnableOption "Enable Bluetooth stack and tools (BlueZ + Blueman)";

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
