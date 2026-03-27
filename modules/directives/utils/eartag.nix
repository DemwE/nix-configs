pkgs: {
  eartag = pkgs.unstable.eartag.overridePythonAttrs (old: {
    propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [
      pkgs.python3Packages.aiohttp-retry
    ];
  });
}
