{ systemVersion, ... }:
{
  imports = [
    ./modules
  ];

  # Allow unfree packages globally (NVIDIA, etc.)
  nixpkgs.config.allowUnfree = true;

  # System version - inherited from flake.nix
  system.stateVersion = systemVersion;
}
