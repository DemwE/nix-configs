{ pkgs, ... }:
let
  eogDesktop = "org.gnome.eog.desktop"; # Eye of GNOME desktop entry
in
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      # Prefer eog for images over browser handlers
      defaultApplications = {
        "image/jpeg" = [ eogDesktop ];
        "image/jpg" = [ eogDesktop ];
        "image/png" = [ eogDesktop ];
        "image/webp" = [ eogDesktop ];
        "image/gif" = [ eogDesktop ];
        "image/bmp" = [ eogDesktop ];
        "image/tiff" = [ eogDesktop ];
        "image/svg+xml" = [ eogDesktop ];
        # Uncomment if you want eog to try opening HEIC/AVIF when supported by gdk-pixbuf plugins
        # "image/heic" = [ eogDesktop ];
        # "image/avif" = [ eogDesktop ];
      };
    };
    # Portals are managed system-wide (modules/features/hyprland.nix)
  };
}
