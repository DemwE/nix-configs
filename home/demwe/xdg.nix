{ config, pkgs, ... }:
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
        # Images -> eog
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

        # Files & text -> editor / file manager
        "text/plain" = [ config.my.desktop.defaultEditor.desktop ];
        "inode/directory" = [ config.my.desktop.defaultFileManager.desktop ];

        # Web content -> browser
        "text/html" = [ config.my.desktop.defaultBrowser.desktop ];
        "x-scheme-handler/http" = [ config.my.desktop.defaultBrowser.desktop ];
        "x-scheme-handler/https" = [ config.my.desktop.defaultBrowser.desktop ];
        "x-scheme-handler/about" = [ config.my.desktop.defaultBrowser.desktop ];
        "application/pdf" = [ config.my.desktop.defaultBrowser.desktop ];
      };
    };
    # Portals are managed system-wide (modules/features/hyprland.nix)
  };
}
