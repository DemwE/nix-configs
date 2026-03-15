{
  description = "NixOS + Home Manager configuration (flakes)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/v0.7.0";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    overlays = import ./modules/overlays { inherit inputs; };
    nixosConfigurations = {
      NixBook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./modules
          ./specialisations.nix
          # Home Manager jako moduł NixOS
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = self.overlays;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.demwe = import ./home/demwe/home.nix;
          }
        ];
      };
    };
  };
}
