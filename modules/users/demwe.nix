{ config, pkgs, ... }:
{
  users.users.demwe = {
    isNormalUser = true;
    description = "DemwE";
    extraGroups = [
      "networkmanager" "wheel" "storage" "plugdev" "libvirtd" "docker"
    ];
    packages = with pkgs; [ ];
  };
}
