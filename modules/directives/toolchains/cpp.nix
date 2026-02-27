# C/C++ toolchain: gcc, clang, cmake, gnumake, gdb, pkg-config
# pkgs: { toolchain-cpp }

pkgs: {
  toolchain-cpp = pkgs.symlinkJoin {
    name = "toolchain-cpp";
    paths = [
      pkgs.gcc
      pkgs.cmake
      pkgs.gnumake
      pkgs.gdb
      pkgs.pkg-config
      pkgs.llvmPackages.clang-unwrapped
      pkgs.clang-tools
    ];
  };
}
