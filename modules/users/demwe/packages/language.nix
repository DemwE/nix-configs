{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    unstable.wordbook
    unstable.dialect
    unstable.eloquent
    unstable.hunspellDicts.en_US-large
    unstable.hunspellDicts.pl_PL
  ];
}
