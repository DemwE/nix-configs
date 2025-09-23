{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.docker;
  inherit (lib) mkEnableOption mkIf;
 in {
  options.my.features.docker.enable = mkEnableOption "Docker daemon and tooling";
  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.groups.docker = { }; # ensure group exists
    environment.systemPackages = [ pkgs.docker ];
  };
}
