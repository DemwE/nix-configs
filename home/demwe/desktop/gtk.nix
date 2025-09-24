{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        variant = "mocha";
      };
      name = "catppuccin-mocha-lavender-standard";
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      name = "Papirus-Dark";
    };

    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaLavender;
      name = "Catppuccin-Mocha-Lavender";
    };

    gtk3.extraConfig = {
      gtk-theme-name = "catppuccin-mocha-lavender-standard";
      gtk-icon-theme-name = "Papirus-Dark";
    };

    gtk4.extraConfig = {
      gtk-theme-name = "catppuccin-mocha-lavender-standard";
      gtk-icon-theme-name = "Papirus-Dark";
    };
  };

  home.sessionVariables = {
    GTK_THEME = "catppuccin-mocha-lavender-standard";
  };
}
