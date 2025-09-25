{ config, pkgs, ... }:
let
  loupeDesktop = "org.gnome.Loupe.desktop"; # GNOME Loupe (Image Viewer) desktop entry
  geditDesktop = "org.gnome.gedit.desktop"; # GNOME Text Editor desktop entry
  papersDesktop = "org.gnome.papers.desktop"; # GNOME Papers desktop entry
  decibelsDesktop = "org.gnome.Decibels.desktop"; # Decibels desktop entry
in
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      # Prefer Loupe for images over browser handlers
      defaultApplications = {
        # Images -> Loupe
        "image/jpeg" = [ loupeDesktop ];
        "image/jpg" = [ loupeDesktop ];
        "image/png" = [ loupeDesktop ];
        "image/webp" = [ loupeDesktop ];
        "image/gif" = [ loupeDesktop ];
        "image/bmp" = [ loupeDesktop ];
        "image/tiff" = [ loupeDesktop ];
        "image/svg+xml" = [ loupeDesktop ];
        # Uncomment if you want Loupe to try opening HEIC/AVIF when supported by gdk-pixbuf plugins
        # "image/heic" = [ loupeDesktop ];
        # "image/avif" = [ loupeDesktop ];

        # Files & text -> editor / file manager
        "text/plain" = [ geditDesktop ];
        "inode/directory" = [ config.my.desktop.defaultFileManager.desktop ];

        # Audio
        "audio/mpeg" = [ decibelsDesktop ];
        "audio/ogg" = [ decibelsDesktop ];
        "audio/wav" = [ decibelsDesktop ];
        "audio/flac" = [ decibelsDesktop ];
        "audio/aac" = [ decibelsDesktop ];
        "audio/mp4a" = [ decibelsDesktop ];
        "audio/mp3" = [ decibelsDesktop ];
        
        # PDFs
        "application/pdf" = [ papersDesktop ];

        # Web content -> browser
        "text/html" = [ config.my.desktop.defaultBrowser.desktop ];
        "x-scheme-handler/http" = [ config.my.desktop.defaultBrowser.desktop ];
        "x-scheme-handler/https" = [ config.my.desktop.defaultBrowser.desktop ];
        "x-scheme-handler/about" = [ config.my.desktop.defaultBrowser.desktop ];
      };
    };
    # Portals are managed system-wide (modules/features/hyprland.nix)
  };
}
