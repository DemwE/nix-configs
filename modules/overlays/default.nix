{
  pkgs-unstable ? null,
  ...
}:
{
  nixpkgs.overlays = [
    (import ./custom.nix)
    (import ./stable.nix)
    (import ./nur.nix)
  ];
}
