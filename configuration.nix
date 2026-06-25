{ systemVersion, ... }:
{
  imports = [
    ./modules
    ./users
    ./groups.nix
    ./paths.nix
  ];

  # Allow unfree packages globally (NVIDIA, etc.)
  nixpkgs.config.allowUnfree = true;

  # System version - inherited from flake.nix
  system.stateVersion = systemVersion;
}
