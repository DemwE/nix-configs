{ pkgs, pkgs-unstable, ... }:
{
  users.users.demwe.packages =
    with pkgs;
    [
      gnome-decoder
      unityhub
    ]
    ++ (with pkgs-unstable; [
      onlyoffice-desktopeditors
    ]);
}
