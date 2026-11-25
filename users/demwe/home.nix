{ config, lib, ... }:
let
  hmRoot = config.my.paths.homeManager + "/demwe/home.nix";
in
lib.mkIf config.my.users.demwe.enable {
  home-manager.users.demwe = import hmRoot;
}
