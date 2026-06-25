{ lib, ... }:
let
  resourcesDir = ./resources;
  homeManagerDir = ./home;
in {
  options.my.paths.resources = lib.mkOption {
    type = lib.types.path;
    readOnly = true;
    default = resourcesDir;
    description = ''Absolute path to the repository's resources directory (images, wallpapers).'';
  };
  options.my.paths.homeManager = lib.mkOption {
    type = lib.types.path;
    readOnly = true;
    default = homeManagerDir;
    description = ''Absolute path to the repository's home manager configuration directory.'';
  };
}
