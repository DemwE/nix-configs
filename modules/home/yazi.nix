{ my, pkgs, lib, ... }:
let p = my.theme.palette; in lib.mkIf true {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_dir_first = true;
        linemode = "size";
        scrolloff = 4;
      };
      opener = {
        edit = [{ run = [ "nvim" "{file}" ]; desc = "Edit"; block = false; for = "unix"; }];
        open = [{ run = [ "xdg-open" "{file}" ]; desc = "Open"; block = false; for = "unix"; }];
      };
      keymap = {
        manager = {
          q = "quit";
          g = { g = "cd /"; }; # gg -> root
          space = "toggle";
          o = "open";
          e = "open --or edit";
          Y = "yank path";
          p = "paste";
          dd = "remove";
          r = "rename";
          f = "filter";
          "/" = "search";
        };
      };
    };
    theme = {
      manager = {
        border_symbol = "│";
        cwd = { fg = p.lavender; bold = true; };
        hovered = { fg = p.base; bg = p.${my.theme.accent}; bold = true; };
        preview_hovered = { fg = p.${my.theme.accent}; italic = true; };
        syntect_theme = "base16";
      };
      status = {
        separator_open = "";
        separator_close = "";
        mode_normal = { fg = p.base; bg = p.${my.theme.accent}; bold = true; };
        mode_select = { fg = p.base; bg = p.yellow; bold = true; };
        mode_unset = { fg = p.base; bg = p.red; bold = true; };
      };
      colors = {
        bg = p.base; fg = p.text; orange = p.peach; red = p.red; green = p.green; blue = p.blue; magenta = p.mauve; yellow = p.yellow;
        hint = p.teal; info = p.sky; warn = p.yellow; error = p.red;
      };
    };
  };
}
