{
  description = "DemwE NixOS – main host DemwE_PC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      # Single target system list (easy to extend later)
      systems = [ "x86_64-linux" ];
      forAllSystems = f: builtins.listToAttrs (map (s: { name = s; value = f s; }) systems);

      # Overlay exposing an `unstable` package set alongside stable
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable { system = final.system; config.allowUnfree = true; };
        })
      ];

      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = overlays;
        config.allowUnfree = true;
      };

      # Home Manager user wiring (kept as a reusable small module)
      hmUser = { config, ... }: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { my = config.my; };
        home-manager.users.demwe = import ./modules/users/demwe-home.nix;
      };

      # Build a NixOS host by name
      mkHost = { hostname, system ? "x86_64-linux", extraModules ? [ ] }: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # Inject overlays
          ({ ... }: { nixpkgs.overlays = overlays; })
          # Host base configuration (imports theme/features + profiles)
          ./hosts/desktop01/configuration.nix
          # Home Manager integration + user
          home-manager.nixosModules.home-manager
          hmUser
        ] ++ extraModules;
      };
    in {
      # Formatter: enables `nix fmt`
      formatter = forAllSystems (system: (mkPkgs system).nixfmt-rfc-style);

      # Primary host
      nixosConfigurations.DemwE_PC = mkHost { hostname = "DemwE_PC"; };

      # Simple dev shell (optional tooling)
      devShells = forAllSystems (system: {
        default = (mkPkgs system).mkShell {
          packages = with (mkPkgs system); [ git nixfmt-rfc-style ];
        };
      });
    };
}
