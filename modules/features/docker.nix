{ lib, config, pkgs, ... }:
/*
 Feature: Docker
 Provides: Docker daemon + CLI tools.
 Enabling this feature will:
  - ensure docker group exists
  - enable the system docker service
  - add docker client package to system packages
*/
let
  cfg = config.my.features.docker;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.docker.enable = mkEnableOption "Enable Docker engine and user tooling";
  config = mkIf cfg.enable {
    # Enable daemon
    virtualisation.docker.enable = true;
    # Create group so user can be added (handled in user module)
    users.groups.docker = { };
    # Provide docker client binaries
    environment.systemPackages = [ pkgs.docker ];
  };
}
