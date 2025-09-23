{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/demwe/home.nix";
in {
  home-manager.sharedModules = [
    ({ lib, ... }: {
      options.my.paths.resources = lib.mkOption {
        type = lib.types.path;
        readOnly = true;
        description = "Absolute path to repository resources directory (mirrors system-level option).";
      };
      options.my.paths.homeManager = lib.mkOption {
        type = lib.types.path;
        readOnly = true;
        description = "Absolute path to repository home-manager configuration directory (mirrors system-level option).";
      };
      config.my.paths.resources = config.my.paths.resources;
      config.my.paths.homeManager = config.my.paths.homeManager;
    })
    (import ../../theme/core.nix)
  ];
  home-manager.users.demwe = import hmRoot;
}
