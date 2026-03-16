{ pkgs-unstable, ... }:
{
  users.users.demwe.packages = with pkgs-unstable; [
    prismlauncher
    vintagestory
    gamescope
    bottles
    eloquent
  ];
}
