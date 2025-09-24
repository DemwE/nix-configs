{ pkgs, ... }:
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
    # Portals are managed system-wide (modules/features/hyprland.nix)
  };
}
