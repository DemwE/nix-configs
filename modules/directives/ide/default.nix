# Aggregator for all IDE packages
# pkgs: { rust-rover, webstorm, clion, pycharm }

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./rust-rover.nix
    ./webstorm.nix
    ./clion.nix
    ./pycharm.nix
  ])
