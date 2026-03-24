# .NET toolchain: gcc-arm-embedded, openocd
# pkgs: { toolchain-arm }

pkgs: {
  toolchain-arm = pkgs.symlinkJoin {
    name = "toolchain-arm";
    paths = [
      pkgs.unstable.gcc-arm-embedded
      pkgs.unstable.openocd
    ];
  };
}
