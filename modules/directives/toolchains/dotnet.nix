# .NET toolchain: dotnet SDK, nuget, mono
# pkgs: { toolchain-dotnet }

pkgs: {
  toolchain-dotnet = pkgs.symlinkJoin {
    name = "toolchain-dotnet";
    paths = [
      pkgs.unstable.dotnetCorePackages.sdk_9_0
      pkgs.unstable.mono
    ];
  };
}
