{ pkgs, ... }:
{
  imports = [
    ./browsers.nix
    ./development.nix
    ./creativity.nix
    ./games.nix
    ./media.nix
    ./utilities.nix
    ./java.nix
    ./typst.nix
    ./language.nix
    ./office.nix
    ./flatpak.nix
    ./other.nix
  ];
}
