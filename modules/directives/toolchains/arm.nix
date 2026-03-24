# .NET toolchain: stm32cubemx, gcc-arm-embedded, openocd
# pkgs: { toolchain-arm }

pkgs: {
  toolchain-arm = pkgs.symlinkJoin {
    name = "toolchain-arm";
    paths = [
      pkgs.unstable.stm32cubemx
      pkgs.unstable.gcc-arm-embedded
      pkgs.unstable.openocd
    ];
  };
}
