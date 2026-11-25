{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/admin/home.nix";
in
lib.mkIf config.my.users.admin.enable {
  home-manager.users.admin = import hmRoot;
}
