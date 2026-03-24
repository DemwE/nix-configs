# Aggregator for all toolchain packages
# pkgs: { toolchain-rust, toolchain-cpp, toolchain-nodejs, toolchain-python, toolchain-dotnet }

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./rust.nix
    ./cpp.nix
    ./nodejs.nix
    ./python.nix
    ./dotnet.nix
    ./arm.nix
  ])
