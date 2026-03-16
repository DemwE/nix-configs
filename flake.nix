{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nur,
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
    in
    {
      nixosConfigurations.NixBook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          home-manager.nixosModules.home-manager
          (
            { ... }:
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = pkgs-unstable;
                  stable = pkgs;
                })
              ];
            }
          )
          ./configuration.nix
        ];
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [ pkgs.nixfmt-rfc-style ];
      };
    };
}
