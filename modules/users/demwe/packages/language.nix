{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    unstable.wordbook
    unstable.dialect
    unstable.hunspellDicts.en_US-large
    unstable.hunspellDicts.pl_PL
  ];
}
