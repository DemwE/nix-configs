# WebStorm package definition with Node.js toolchain in PATH
# pkgs: { webstorm }

pkgs:
let
  toolchain = (import ../toolchains/nodejs.nix pkgs).toolchain-nodejs;
in {
  webstorm = pkgs.unstable.jetbrains.webstorm.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/webstorm \
        --prefix PATH : ${pkgs.lib.makeBinPath [ toolchain ]}
    '';
  });
}
