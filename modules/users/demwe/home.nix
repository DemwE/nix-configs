{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/demwe/home.nix";
in {
  # Make Home Manager use the system's pkgs (with overlays applied)
  home-manager.useGlobalPkgs = true;
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
    (import ../../desktop.nix)
  ];
  home-manager.backupFileExtension = ".backup";
  home-manager.users.demwe = import hmRoot;
}
