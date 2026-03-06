# .NET toolchain: dotnet SDK (binary), mono
# pkgs: { toolchain-dotnet }

pkgs: {
  toolchain-dotnet = pkgs.symlinkJoin {
    name = "toolchain-dotnet";
    paths = [
      pkgs.unstable.dotnetCorePackages.sdk_10_0-bin
      pkgs.unstable.mono
    ];
  };
}
