{ config, pkgs, ... }:

{
  virtualisation.incus = {
    enable = true;
    ui.enable = true;
  };
  networking.firewall.trustedInterfaces = [ "ibr0" ];
}