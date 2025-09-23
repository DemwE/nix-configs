{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/demwe/home.nix";
  # Lightweight bridge module: re-declare only needed options so HM can see them.
  pathsBridge = { lib, config, ... }: {
    options.my.paths = {
      resources = lib.mkOption {
        type = lib.types.path; readOnly = true; description = "Repo resources directory (shared).";
      };
      homeManager = lib.mkOption {
        type = lib.types.path; readOnly = true; description = "Repo home manager tree (shared).";
      };
    };
    config.my.paths = {
      resources = config.my.paths.resources; # reuse system value
      homeManager = config.my.paths.homeManager;
    };
  };
in {
  home-manager.sharedModules = [
    (import ../../theme/core.nix) # provides my.theme.* (palette)
    pathsBridge
  ];
  home-manager.users.demwe = import hmRoot;
}
