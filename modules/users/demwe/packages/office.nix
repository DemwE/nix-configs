{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    gnome-decoder
    unityhub
    unstable.onlyoffice-desktopeditors
  ];
}
