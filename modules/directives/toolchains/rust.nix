# Rust toolchain: rustc, cargo, clippy, rustfmt, rust-analyzer, gcc, gnumake, pkg-config
# pkgs: { toolchain-rust }
# Version management via ~/.rustup/toolchains/ symlinks (home/demwe/rust.nix)
# rustup binary required by RustRover to locate stdlib from ~/.rustup/toolchains/

pkgs: {
  toolchain-rust = pkgs.symlinkJoin {
    name = "toolchain-rust";
    paths = [
      pkgs.rustup
      pkgs.rust-analyzer
      pkgs.gcc
      pkgs.gnumake
      pkgs.pkg-config
    ];
  };
}
