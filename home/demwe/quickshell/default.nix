{ config, pkgs, ... }:
let
  quickshellPkg = pkgs.unstable.quickshell;
  qt5compat = pkgs.unstable.qt6Packages.qt5compat;
  # `kdePackages.kirigami` is a thin wrapper around the real package,
  # which lives in `passthru.unwrapped` and contains the QML modules.
  kirigami = pkgs.unstable.kdePackages.kirigami.passthru.unwrapped;

  # quickshell's own wrapper doesn't ship Qt5Compat.GraphicalEffects or
  # org.kde.kirigami, which the shell config uses (DropShadow, Kirigami.Icon, ...).
  # Re-wrap the binary to put those QML modules on the import path.
  quickshell = pkgs.symlinkJoin {
    name = "quickshell-wrapped";
    paths = [ quickshellPkg ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/quickshell" \
        --prefix QML2_IMPORT_PATH ':' "${qt5compat}/lib/qt-6/qml" \
        --prefix QML2_IMPORT_PATH ':' "${kirigami}/lib/qt-6/qml"
    '';
  };
in
{
  programs.quickshell = {
    enable = true;
    package = quickshell;
    systemd.enable = true;
  };
}