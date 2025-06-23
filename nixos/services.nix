{ config, ... }:
{
  services = {
    udisks2.enable = true;
    gvfs.enable = true;
    udisks2.mountOnMedia = true;
  };
}
