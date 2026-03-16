{ pkgs-unstable, ... }:
{
  users.users.demwe.packages = with pkgs-unstable; [
    wordbook
    dialect
    hunspellDicts.en_US-large
    hunspellDicts.pl_PL
  ];
}
