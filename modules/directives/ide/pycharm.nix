# PyCharm package definition with Python toolchain in PATH
# pkgs: { pycharm }

pkgs:
let
  toolchain = (import ../toolchains/python.nix pkgs).toolchain-python;
in {
  pycharm = pkgs.unstable.jetbrains.pycharm.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/pycharm \
        --prefix PATH : ${pkgs.lib.makeBinPath [ toolchain ]}
    '';
  });
}
