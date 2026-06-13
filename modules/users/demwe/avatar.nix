{ pkgs, lib, config, ... }:
let
  accountConfig = pkgs.writeText "demwe-accountsservice" ''
   [User]
   Icon=/var/lib/AccountsService/icons/demwe
   SystemAccount=false
  '';
in
{
  config = lib.mkIf config.my.users.demwe.enable {
    services.accounts-daemon.enable = true;

    systemd.tmpfiles.rules = [
      "C+ /var/lib/AccountsService/icons/demwe - - - - ${config.my.paths.resources}/demwe/avatar.jpg"
      "C+ /var/lib/AccountsService/users/demwe  - - - - ${accountConfig}"
    ];
  };
}
