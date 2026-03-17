{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    gnome-graphs
    nucleus
    qbittorrent
    ventoy-full-gtk
    foliate
    varia
    wireshark
    blackbox-terminal
  ];
}
