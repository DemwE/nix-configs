{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    brave
  ];
}
