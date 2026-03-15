{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: (import ./unstable.nix { inherit inputs final prev; }))
    (final: prev: (import ./stable.nix { inherit inputs final prev; }))
    (final: prev: (import ./nur.nix { inherit inputs final prev; }))
    (import ./custom.nix)
  ];
}
