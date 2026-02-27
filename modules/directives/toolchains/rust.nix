# Rust toolchain: rustup, cargo, gcc, gnumake, pkg-config
# pkgs: { toolchain-rust }

pkgs: {
  toolchain-rust = pkgs.symlinkJoin {
    name = "toolchain-rust";
    paths = [
      pkgs.rustup
      pkgs.gcc
      pkgs.gnumake
      pkgs.pkg-config
    ];
  };
}
