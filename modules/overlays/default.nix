{ ... }:
{
  nixpkgs.overlays = [
    (import ./custom.nix)
    (import ./unstable.nix)
    (import ./stable.nix)
    (import ./nur.nix)
  ];
}
