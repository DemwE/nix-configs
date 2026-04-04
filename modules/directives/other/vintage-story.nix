# Vintage Story with gamescope wrapper
# pkgs: { vintage-story }

pkgs:
let
  gamescope = pkgs.unstable.gamescope;
  wrapper = pkgs.writeScriptBin "vintage-story-wrapper" ''
    #!${pkgs.stdenv.shell}
    exec ${gamescope}/bin/gamescope \
      -w 1920 -h 1200 \
      -W 3840 -H 2400 \
      -F fsr -f -- \
      "${pkgs.unstable.vintagestory}/bin/vintage-story" "$@"
  '';
in
{
  vintage-story = pkgs.unstable.vintagestory.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];

    postInstall = (oldAttrs.postInstall or "") + ''
      rm -f $out/bin/vintage-story
      makeWrapper ${wrapper}/bin/vintage-story-wrapper $out/bin/vintage-story
    '';
  });
}
