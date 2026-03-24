{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
    }:
    let
      # Define the system version for use in configurations
      systemVersion = "25.11";

      # Import Nixpkgs with the appropriate system and unfree settings
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      # Common NixOS system configuration
      nixosModule =
        { lib, ... }:
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = pkgs-unstable;
            })
          ];
        };
    in
    {
      # Host: NixBook (laptop)
      nixosConfigurations.NixBook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit pkgs-unstable;
          systemVersion = systemVersion;
        };
        modules = [
          home-manager.nixosModules.home-manager
          nixosModule
          ./hosts/NixBook
          ./configuration.nix
        ];
      };

      nixosConfigurations.DemwEPC = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit pkgs-unstable;
          systemVersion = systemVersion;
        };
        modules = [
          home-manager.nixosModules.home-manager
          nixosModule
          ./hosts/DemwEPC
          ./configuration.nix
        ];
      };

      # Add more hosts here:
      # nixosConfigurations.ServerName = nixpkgs.lib.nixosSystem { ... };

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [ pkgs.nixfmt-rfc-style ];
      };
    };
}
