{
  my,
  lib,
  pkgs,
  config,
  ...
}:
let
  p = my.theme.palette;
  accent = my.theme.accent;
  inherit (config.lib.formats.rasi) mkLiteral;
in
lib.mkIf my.features.hyprland.enable {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run"; # filebrowser often slow; can re-add
      show-icons = true;
      icon-theme = "Papirus";
      font = "${my.theme.font.family} 12";
      drun-display-format = "{icon} {name}";
      display-drun = "Apps";
      display-run = "Run";
      matching = "fuzzy";
      sort = true;
    };
    theme = {
      "*" = {
        bg = mkLiteral p.base;
        bg-alt = mkLiteral p.surface0;
        bg-hover = mkLiteral p.surface1;
        bg-active = mkLiteral p.surface2;
        fg = mkLiteral p.text;
        fg-dim = mkLiteral p.subtext0;
        fg-alt = mkLiteral p.subtext1;
        accent = mkLiteral (p.${accent} or p.lavender);
        red = mkLiteral p.red;
        yellow = mkLiteral p.yellow;
        green = mkLiteral p.green;
        border-color = mkLiteral (p.${accent} or p.lavender);
        urgent = mkLiteral p.red;
        spacing = mkLiteral "6px";
      };
      window = {
        transparency = "real";
        width = mkLiteral "960px";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        x-offset = 0;
        y-offset = 0;
        padding = mkLiteral "18px";
        border = mkLiteral "2px";
        border-radius = mkLiteral "18px";
        background-color = mkLiteral "@bg";
        border-color = mkLiteral "@accent";
  # Background image provided via resources.nix (symlink in ~/.config/resources)
        background-image = mkLiteral "url(\"${config.home.homeDirectory}/.config/resources/rofi-background.jpg\")";
        background-size = mkLiteral "cover";
      };
      mainbox = {
        spacing = mkLiteral "12px";
        children = mkLiteral "[ inputbar, listview ]";
      };
      inputbar = {
        children = mkLiteral "[ prompt, entry ]";
        background-color = mkLiteral "@bg-alt";
        padding = mkLiteral "6px 12px";
        border-radius = mkLiteral "10px";
        border = mkLiteral "1px";
        border-color = mkLiteral "@accent";
      };
      prompt = {
        padding = mkLiteral "0 8px 0 0";
        text-color = mkLiteral "@accent";
      };
      entry = {
        expand = true;
        placeholder = "Type to search…";
        placeholder-color = mkLiteral "@fg-dim";
        text-color = mkLiteral "@fg";
        cursor = mkLiteral "ibeam";
      };
      listview = {
        columns = 1;
        lines = 12;
        fixed-height = true;
        dynamic = false;
        border = 0;
        scrollbar = mkLiteral "false";
        spacing = mkLiteral "4px";
      };
      element = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
        border-radius = mkLiteral "8px";
        padding = mkLiteral "6px 10px";
      };
      "element selected" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg";
      };
      "element urgent" = {
        background-color = mkLiteral "@red";
        text-color = mkLiteral "@bg";
      };
      "element active" = {
        background-color = mkLiteral "@green";
        text-color = mkLiteral "@bg";
      };
      message = {
        background-color = mkLiteral "@bg-alt";
        border-radius = mkLiteral "12px";
        padding = mkLiteral "8px";
      };
      textbox = {
        text-color = mkLiteral "@fg";
      };
    };
  };
}
