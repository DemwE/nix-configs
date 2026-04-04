{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    unstable.prismlauncher
    custom.vintage-story
    unstable.openrct2
  ];
}
