{ config, lib, ... }:
/*
 Users aggregator
 Import this to pull in all user account definitions.
 Add new user files in this directory and list them here.
*/
{
  imports = [
    ./demwe
    ./admin
  ];

  config = lib.mkIf (config.my.users.demwe.enable || config.my.users.admin.enable) {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { nixosConfig = config; };
    home-manager.sharedModules = [
      ../paths.nix
      ../modules/theme/core.nix
    ];
    home-manager.backupFileExtension = "backup";
  };
}