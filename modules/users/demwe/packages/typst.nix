{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs.unstable; [
    typesetter
    typst
    tinymist
  ];
}
