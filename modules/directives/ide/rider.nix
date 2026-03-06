# Rider package definition
# pkgs: { rider }
# DOTNET_ROOT points at ~/.toolchains/dotnet — the standard .NET SDK discovery mechanism.
# Rider (and all .NET tooling) reads DOTNET_ROOT to locate the SDK.

pkgs:
{
  rider = pkgs.unstable.jetbrains.rider.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/rider \
        --run 'export DOTNET_ROOT="$HOME/.toolchains/dotnet"'
    '';
  });
}
