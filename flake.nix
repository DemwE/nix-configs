{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      systemVersion = "25.11";
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
              stable = pkgs;
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
