{ ... }:
{
  nixpkgs.overlays = [
    (import ./unstable.nix)
    (import ./stable.nix)
    (import ./nur.nix)
  ];
}
