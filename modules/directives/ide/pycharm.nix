# PyCharm package definition
# pkgs: { pycharm }
# Note: ~/.pyenv/versions/ symlinks (created by home/demwe/python.nix) let PyCharm auto-detect Python interpreters.

pkgs:
{
  pycharm = pkgs.unstable.jetbrains.pycharm.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/pycharm
    '';
  });
}
