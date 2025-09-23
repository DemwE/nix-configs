{ lib, config, pkgs, ... }:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.my.theme;
in {
  options.my.theme = {
    flavor = mkOption {
      type = types.str;
      default = "mocha";
      description = "Catppuccin flavor (e.g. mocha, latte, frappe, macchiato)";
    };
    accent = mkOption {
      type = types.str;
      default = "lavender";
      description = "Primary accent name used across themed components.";
    };
    font.family = mkOption {
      type = types.str;
      default = "Noto Sans";
      description = "Primary UI font family";
    };
    font.sizeSDDM = mkOption {
      type = types.str;
      default = "9";
      description = "Font size passed to SDDM theme override";
    };
    packageName = mkOption {
      type = types.str;
      readOnly = true;
      description = "Derived catppuccin package/theme base name (read-only).";
    };
    sddmTheme = mkOption {
      type = types.str;
      readOnly = true;
      description = "Derived SDDM theme name (read-only).";
    };
    gtkTheme = mkOption {
      type = types.str;
      readOnly = true;
      description = "Derived GTK theme variant (read-only).";
    };
      wallpapers = mkOption {
        type = types.listOf (types.attrsOf types.str);
        default = [];
        description = "List of wallpaper specs: { monitor = \"DP-1\"; path = ./wall.jpg; }.";
      };
      lock = {
        avatar = mkOption {
          type = types.nullOr types.path;
          default = null;
          description = "Optional avatar image for lock screen.";
        };
      };
      font.terminal = mkOption {
        type = types.str;
        default = "JetBrainsMono Nerd Font";
        description = "Terminal font family";
      };
    palette = mkOption {
      type = types.attrsOf types.str;
      readOnly = true;
      description = "Derived Catppuccin color palette for the selected flavor (read-only).";
    };
  };

  # Expose a few convenient derived values
  config = let
    palettes = {
      mocha = {
        base = "#1e1e2e"; mantle = "#181825"; crust = "#11111b";
        surface0 = "#313244"; surface1 = "#45475a"; surface2 = "#585b70";
        overlay0 = "#6c7086"; overlay1 = "#7f849c"; overlay2 = "#9399b2";
        subtext0 = "#a6adc8"; subtext1 = "#bac2de"; text = "#cdd6f4";
        lavender = "#b4befe"; blue = "#89b4fa"; sapphire = "#74c7ec"; sky = "#89dceb";
        teal = "#94e2d5"; green = "#a6e3a1"; yellow = "#f9e2af"; peach = "#fab387";
        maroon = "#eba0ac"; red = "#f38ba8"; mauve = "#cba6f7"; pink = "#f5c2e7";
        flamingo = "#f2cdcd"; rosewater = "#f5e0dc";
      };
      macchiato = {
        base = "#24273a"; mantle = "#1e2030"; crust = "#181926";
        surface0 = "#363a4f"; surface1 = "#494d64"; surface2 = "#5b6078";
        overlay0 = "#6e738d"; overlay1 = "#8087a2"; overlay2 = "#939ab7";
        subtext0 = "#a5adcb"; subtext1 = "#b8c0e0"; text = "#cad3f5";
        lavender = "#b7bdf8"; blue = "#8aadf4"; sapphire = "#7dc4e4"; sky = "#91d7e3";
        teal = "#8bd5ca"; green = "#a6da95"; yellow = "#eed49f"; peach = "#f5a97f";
        maroon = "#ee99a0"; red = "#ed8796"; mauve = "#c6a0f6"; pink = "#f5bde6";
        flamingo = "#f0c6c6"; rosewater = "#f4dbd6";
      };
      frappe = {
        base = "#303446"; mantle = "#292c3c"; crust = "#232634";
        surface0 = "#414559"; surface1 = "#51576d"; surface2 = "#626880";
        overlay0 = "#737994"; overlay1 = "#838ba7"; overlay2 = "#949cbb";
        subtext0 = "#a5adce"; subtext1 = "#b5bfe2"; text = "#c6d0f5";
        lavender = "#babbf1"; blue = "#8caaee"; sapphire = "#85c1dc"; sky = "#99d1db";
        teal = "#81c8be"; green = "#a6d189"; yellow = "#e5c890"; peach = "#ef9f76";
        maroon = "#ea999c"; red = "#e78284"; mauve = "#ca9ee6"; pink = "#f4b8e4";
        flamingo = "#eebebe"; rosewater = "#f2d5cf";
      };
      latte = {
        base = "#eff1f5"; mantle = "#e6e9ef"; crust = "#dce0e8";
        surface0 = "#ccd0da"; surface1 = "#bcc0cc"; surface2 = "#acb0be";
        overlay0 = "#9ca0b0"; overlay1 = "#8c8fa1"; overlay2 = "#7c7f93";
        subtext0 = "#6c6f85"; subtext1 = "#5c5f77"; text = "#4c4f69";
        lavender = "#7287fd"; blue = "#1e66f5"; sapphire = "#209fb5"; sky = "#04a5e5";
        teal = "#179299"; green = "#40a02b"; yellow = "#df8e1d"; peach = "#fe640b";
        maroon = "#e64553"; red = "#d20f39"; mauve = "#8839ef"; pink = "#ea76cb";
        flamingo = "#dd7878"; rosewater = "#dc8a78";
      };
    };
    palette = palettes.${cfg.flavor} or palettes.mocha;
  in {
    my.theme.packageName = "catppuccin-${cfg.flavor}";
    my.theme.sddmTheme = "catppuccin-${cfg.flavor}";
    my.theme.gtkTheme = "catppuccin-${cfg.flavor}-${cfg.accent}-standard";
    my.theme.palette = palette;
  };
}
