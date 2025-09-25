{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/demwe/home.nix";
in {
  # Make Home Manager use the system's pkgs (with overlays applied)
  home-manager.useGlobalPkgs = true;
  # Expose the full NixOS config to HM modules as `nixosConfig`
  home-manager.extraSpecialArgs = { nixosConfig = config; };
  home-manager.sharedModules = [
    ({ lib, nixosConfig, ... }: {
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
      # Bridge system-level desktop options into Home Manager so HM modules see user overrides
      # Use nixosConfig (passed via extraSpecialArgs) to get the NixOS-level value
      config.my.desktop = nixosConfig.my.desktop;
    })
    (import ../../theme/core.nix)
    (import ../../desktop.nix)
  ];
  home-manager.backupFileExtension = ".backup";
  home-manager.users.demwe = import hmRoot;
}
