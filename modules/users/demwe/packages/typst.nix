{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    unstable.typesetter
    unstable.typst
    unstable.tinymist
  ];
}
