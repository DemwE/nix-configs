{
  description = "NixOS configuration";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preservation.url = "github:nix-community/preservation";
    nix-dokploy.url = "github:el-kurto/nix-dokploy";
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/v0.7.0";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      preservation,
      nix-flatpak,
      nix-dokploy,
    }:
    let
      systemVersion = "26.05";

      # Dynamic overlay: exposes nixpkgs-unstable as pkgs.unstable
      nixosModule =
        { ... }:
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = prev.stdenv.hostPlatform.system;
                config.allowUnfree = true;
              };
            })
          ];
        };

      mkPkgsUnstable = system: import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      baseSpecialArgs = {
        inherit systemVersion nix-flatpak;
      };
    in
    {
      # Host: NixBook (laptop)
      nixosConfigurations.NixBook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = baseSpecialArgs // {
          pkgs-unstable = mkPkgsUnstable "x86_64-linux";
        };
        modules = [
          preservation.nixosModules.default
          home-manager.nixosModules.home-manager
          nix-dokploy.nixosModules.default
          nixosModule
          ./hosts/NixBook
          ./configuration.nix
        ];
      };

      # Host: DemwEPC (desktop)
      nixosConfigurations.DemwEPC = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = baseSpecialArgs // {
          pkgs-unstable = mkPkgsUnstable "x86_64-linux";
        };
        modules = [
          home-manager.nixosModules.home-manager
          nix-dokploy.nixosModules.default
          nixosModule
          ./hosts/DemwEPC
          ./configuration.nix
        ];
      };

      # Host: N1 (server)
      nixosConfigurations.N1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = baseSpecialArgs // {
          pkgs-unstable = mkPkgsUnstable "x86_64-linux";
        };
        modules = [
          home-manager.nixosModules.home-manager
          nixosModule
          ./hosts/N1
          ./configuration.nix
        ];
      };

      devShells.x86_64-linux.default =
        let
          pkgs' = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs'.mkShell {
          buildInputs = [ pkgs'.nixfmt ];
        };
    };
}
