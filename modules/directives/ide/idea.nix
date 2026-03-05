# IntelliJ IDEA Ultimate package definition with Java toolchain in PATH
# pkgs: { idea }
# Note: ~/.jdks/ symlinks (created by home/demwe/java.nix) let IDEA auto-detect all JDK versions.

pkgs:
{
  idea = pkgs.unstable.jetbrains.idea.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/idea
    '';
  });
}
