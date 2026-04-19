# Expose Node.js and Bun versions to WebStorm via ~/.nvm/versions/
# WebStorm automatically scans ~/.nvm/versions/ for Node.js installations.
{ pkgs, ... }:
let
  nodes = {
    "v${pkgs.nodejs_20.version}" = pkgs.nodejs_20;
    "v${pkgs.nodejs_22.version}" = pkgs.nodejs_22;
    "v${pkgs.nodejs_24.version}" = pkgs.nodejs_24;
  };

  buns = {
    "v${pkgs.unstable.bun.version}" = pkgs.unstable.bun;
  };

  mkNvmFiles = prefix: versionSet: builtins.listToAttrs (
    map (ver: {
      name  = "${prefix}/${ver}";
      value = { source = versionSet.${ver}; };
    }) (builtins.attrNames versionSet)
  );
in
{
  home.file = (mkNvmFiles ".nvm/versions/node" nodes) 
           // (mkNvmFiles ".nvm/versions/bun" buns);
}