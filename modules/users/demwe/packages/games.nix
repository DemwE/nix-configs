{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    unstable.prismlauncher
    unstable.vintagestory
    unstable.gamescope
    unstable.bottles
    unstable.eloquent
  ];
}
