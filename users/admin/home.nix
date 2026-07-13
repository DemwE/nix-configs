{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/admin/home.nix";
in
lib.mkIf config.my.users.admin.enable {
  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = { nixosConfig = config; };
  home-manager.sharedModules = [
    (import ../../paths.nix)
    (import ../../modules/theme/core.nix)
  ];
  home-manager.backupFileExtension = "backup";
  home-manager.users.admin = import hmRoot;
}
