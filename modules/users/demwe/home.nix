{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/demwe/home.nix";
in {
  # Make Home Manager use the system's pkgs (with overlays applied)
  home-manager.useGlobalPkgs = true;
  # Expose the full NixOS config to HM modules as `nixosConfig`
  home-manager.extraSpecialArgs = { nixosConfig = config; };
  home-manager.sharedModules = [
    # Ensure HM knows about the same custom options used by the system
    (import ../../paths.nix)
    (import ../../theme/core.nix)
    (import ../../desktop.nix)
    # Bridge system-level desktop values into Home Manager (after options are declared)
    ({ nixosConfig, ... }: {
      config.my.desktop = nixosConfig.my.desktop;
    })
  ];
  home-manager.backupFileExtension = "backup";
  home-manager.users.demwe = import hmRoot;
}
