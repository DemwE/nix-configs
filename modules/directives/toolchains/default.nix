# Aggregator for all toolchain packages
# pkgs: { toolchain-rust, toolchain-cpp, toolchain-web }

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./rust.nix
    ./cpp.nix
    ./nodejs.nix
  ])
