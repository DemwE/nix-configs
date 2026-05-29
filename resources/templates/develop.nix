{
  description = ""; # Optional description of the development environment

  # Define the inputs for the development environment, such as nixpkgs or other dependencies
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Packages for development
        ];

        env = {
          NAME = "moj-projekt";
        };

        # Optional: shell hook to run when entering the dev shell
        # shellHook = ''
        # '';
      };
    };
}