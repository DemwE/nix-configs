{ pkgs, config, ... }:
let
  accountConfig = pkgs.writeText "demwe-accountsservice" ''
   [User]
   Icon=/var/lib/AccountsService/icons/demwe
   SystemAccount=false
  '';
in
{
  services.accounts-daemon.enable = true;

  # Set user avatar for AccountsService (GDM, GNOME settings)
  # Use C+ to copy instead of L+ to symlink - AccountsService needs direct file access
  systemd.tmpfiles.rules = [
    "C+ /var/lib/AccountsService/icons/demwe - - - - ${config.my.paths.resources}/avatar.jpg"
    "C+ /var/lib/AccountsService/users/demwe  - - - - ${accountConfig}"
  ];
}
