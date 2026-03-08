# IntelliJ IDEA Ultimate package definition with Java toolchain in PATH
# pkgs: { idea }
# Note: ~/.jdks/ symlinks (created by home/demwe/java.nix) let IDEA auto-detect all JDK versions.
# ~/.toolchains/nodejs/bin injected so the GitHub Copilot plugin can find Node.js.

pkgs:
{
  idea = pkgs.unstable.jetbrains.idea.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/idea \
        --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  });
}
