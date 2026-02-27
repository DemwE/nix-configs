# CLion package definition with C/C++ toolchain in PATH
# pkgs: { clion }

pkgs:
let
  toolchain = (import ../toolchains/cpp.nix pkgs).toolchain-cpp;
in {
  clion = pkgs.unstable.jetbrains.clion.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/clion \
        --prefix PATH : ${pkgs.lib.makeBinPath [ toolchain ]}
    '';
  });
}
