# Rider package definition with .NET toolchain in PATH
# pkgs: { rider }

pkgs:
let
  toolchain = (import ../toolchains/dotnet.nix pkgs).toolchain-dotnet;
in {
  rider = pkgs.unstable.jetbrains.rider.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/rider \
        --prefix PATH : ${pkgs.lib.makeBinPath [ toolchain ]}
    '';
  });
}
