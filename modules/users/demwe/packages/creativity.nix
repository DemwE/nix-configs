{ pkgs, ... }:
{
  users.users.demwe.packages =
    (with pkgs; [
      gimp
      blender
    ])
    ++ (with pkgs.unstable; [
      obs-studio
      krita
      aseprite
    ]);
}
