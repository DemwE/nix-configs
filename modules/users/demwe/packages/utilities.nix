{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    gparted
    collision
    apostrophe
    winbox4
    custom.compress
    custom.decompress
    custom.battery-watch
    custom.battery-info
    custom.nvidia-offload
    dust
    toybox
    powertop
  ];
}
