# Packages with cleared knownVulnerabilities
# Use: pkgs.custom.ventoy

pkgs: {
  ventoy = pkgs.ventoy.overrideAttrs (old: {
    meta = old.meta // {
      knownVulnerabilities = [ ];
    };
  });
}
