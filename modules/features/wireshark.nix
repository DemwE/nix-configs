{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.wireshark;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.wireshark.enable = mkEnableOption "Enable Wireshark network protocol analyzer";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wireshark ];
  };
}
