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
      system = "x86_64-linux";
      systemVersion = "26.05";

      mkPkgsUnstable = s: import nixpkgs-unstable {
        system = s;
        config.allowUnfree = true;
      };

      nixosModule =
        { ... }:
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = mkPkgsUnstable prev.stdenv.hostPlatform.system;
            })
          ];
        };

      baseSpecialArgs = {
        inherit systemVersion nix-flatpak;
      };

      commonNixosModules = [
        home-manager.nixosModules.home-manager
        nix-dokploy.nixosModules.default
        nixosModule
        ./configuration.nix
      ];

      hosts = {
        NixBook = [ preservation.nixosModules.default ];
        DemwEPC = [ ];
        N1 = [ ];
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (
        name: extraMods:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = baseSpecialArgs // {
            pkgs-unstable = mkPkgsUnstable system;
          };
          modules = extraMods ++ [ ./hosts/${name} ] ++ commonNixosModules;
        }
      ) hosts;

      devShells.x86_64-linux.default =
        let
          pkgs' = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs'.mkShell {
          buildInputs = [ pkgs'.nixfmt ];
        };
    };
}
