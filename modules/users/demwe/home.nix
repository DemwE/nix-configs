{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/demwe/home.nix";
in
{
  config = lib.mkIf config.my.users.demwe.enable {
    home-manager.useGlobalPkgs = true;
    home-manager.extraSpecialArgs = { nixosConfig = config; };
    home-manager.sharedModules = [
      (import ../../paths.nix)
      (import ../../theme/core.nix)
    ];
    home-manager.backupFileExtension = "backup";
    home-manager.users.demwe = import hmRoot;
  };
}
