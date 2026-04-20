{ lib, config, ... }:
let
  cfg = config.my.features.atuin;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.atuin.enable = mkEnableOption "Enable Atuin shell history";

  config = mkIf cfg.enable {
    services.atuin.enable = true;
  };
}