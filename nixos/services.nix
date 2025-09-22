{ config, ... }:
{
  services = {
    udisks2.enable = true;
    gvfs.enable = true;
    udisks2.mountOnMedia = true;
    tumbler.enable = true; 
    gnome.gnome-keyring.enable = true;
  };
  virtualisation = {
    docker.enable = true;
  };
}
