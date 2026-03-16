{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    unstable.onlyoffice-desktopeditors
  ];
}
