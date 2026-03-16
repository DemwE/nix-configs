{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    unstable.prismlauncher
    unstable.vintagestory
  ];
}
