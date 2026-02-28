# Aggregator for all toolchain packages
# pkgs: { toolchain-rust, toolchain-cpp, toolchain-nodejs, toolchain-python }

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./rust.nix
    ./cpp.nix
    ./nodejs.nix
    ./python.nix
  ])
