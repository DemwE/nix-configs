# rust-rover package definition with Rust toolchain in PATH
# pkgs: { rust-rover }

pkgs:
let
  toolchain = (import ../toolchains/rust.nix pkgs).toolchain-rust;
in {
  rust-rover = pkgs.unstable.jetbrains.rust-rover.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/rust-rover \
        --prefix PATH : ${pkgs.lib.makeBinPath [ toolchain ]}
    '';
  });
}
