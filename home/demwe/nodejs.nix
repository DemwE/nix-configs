# Expose Node.js versions to WebStorm via ~/.nvm/versions/node/
# WebStorm automatically scans ~/.nvm/versions/node/ for Node.js installations.
{ pkgs, ... }:
let
  nodes = {
    "v${pkgs.nodejs_20.version}" = pkgs.nodejs_20;
    "v${pkgs.nodejs_22.version}" = pkgs.nodejs_22;
    "v${pkgs.nodejs_24.version}" = pkgs.nodejs_24;
  };
in
{
  home.file = builtins.listToAttrs (
    map (ver: {
      name  = ".nvm/versions/node/${ver}";
      value = { source = nodes.${ver}; };
    }) (builtins.attrNames nodes)
  );
}
