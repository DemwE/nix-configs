{
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./specialisations.nix
  ];

  # Allow unfree packages globally (NVIDIA, etc.)
  nixpkgs.config.allowUnfree = true;

  # System version - same as in flake.nix systemVersion
  system.stateVersion = "25.11";
}
