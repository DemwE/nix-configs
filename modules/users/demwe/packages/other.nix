{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    gnome-graphs
    nucleus
    qbittorrent
  ];
}
