{ config, pkgs, ... }:

let
  # LUB z GitHub (wymaga fetchFromGitHub)
  nix-archiver = (pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "DemwE";
    repo = "nix-archiver";
    rev = "master";  # Changed from main to master
    sha256 = "sha256-CWwxZjkqI50VVKuP0umG4W6O6WRldg3jxbFCRElDGKo=";  # użyj nix-prefetch-url
  }) {}).overrideAttrs (oldAttrs: {
    buildInputs = (oldAttrs.buildInputs or []) ++ [ pkgs.openssl ];
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.pkg-config pkgs.perl ];
    OPENSSL_NO_VENDOR = "1";  # Use system OpenSSL instead of building from source
  });
in
{
  environment.systemPackages = [ nix-archiver ];
}