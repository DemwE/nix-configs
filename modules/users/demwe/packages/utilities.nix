{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    gparted
    collision
    apostrophe
    unstable.winbox4
    custom.compress
    custom.decompress
    custom.battery-watch
    custom.battery-info
    custom.nvidia-offload
    custom.switch
    dust
    toybox
    powertop
    unstable.gamescope
    unstable.bottles
  ];
}
