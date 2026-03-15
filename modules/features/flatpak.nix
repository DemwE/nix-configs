{
  lib,
  config,
  ...
}:
/*
  Feature: Flatpak
  Provides: Declarative Flatpak support via nix-flatpak.
  Enabling this feature will:
   - import the nix-flatpak NixOS module
   - inject the nix-flatpak Home Manager module via sharedModules
   - enable the system Flatpak service
   - register the Flathub remote for all users
  Per-user packages are declared in modules/users/<user>/packages.nix via
  home-manager.users.<name>.services.flatpak.packages.
*/
let
  cfg = config.my.features.flatpak;
  inherit (lib) mkEnableOption mkIf;
in
{

  options.my.features.flatpak = {
    enable = mkEnableOption "Enable declarative Flatpak support via nix-flatpak";
  };

  config = mkIf cfg.enable {

    services.flatpak = {
      enable = true;
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
    };
  };
}
