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
    dust
    croc
    powertop
    unstable.atlas
    unstable.gamescope
    unstable.bottles
    speedtest-cli
    custom.ventoy
    foliate
    varia
    unstable.crosspipe
    custom.eartag
    unstable.cavalier
    file-roller
  ];
}
