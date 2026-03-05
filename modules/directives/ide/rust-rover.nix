# rust-rover package definition
# pkgs: { rust-rover }
# Toolchain auto-detected via ~/.rustup/toolchains/ (managed by home/demwe/rust.nix)
# RustRover reads ~/.rustup/settings.toml and scans ~/.rustup/toolchains/ — no PATH hack needed.

pkgs:
{
  rust-rover = pkgs.unstable.jetbrains.rust-rover.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/rust-rover
    '';
  });
}
