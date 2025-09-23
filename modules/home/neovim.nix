{ my, pkgs, lib, config, ... }:
let
  # Map Catppuccin flavors directly; NvChad picks theme by name "catppuccin"; flavor can be used in overrides.
  flavor = my.theme.flavor; # mocha, macchiato, frappe, latte
in
lib.mkIf true {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # We let NvChad manage plugins – no Nix plugin list here for faster updates.
    extraLuaConfig = ''
      -- NvChad will load its own runtime; custom overrides live in lua/custom/
    '';
  };

  # Activation script: clone NvChad only if not already present (idempotent, keeps user local changes).
  home.activation.installNvChad = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    NVIM_DIR="${config.xdg.configHome}/nvim"
    if [ ! -d "$NVIM_DIR" ] || [ ! -d "$NVIM_DIR/.git" ]; then
      echo "[nvchad] cloning NvChad into $NVIM_DIR" >&2
      rm -rf "$NVIM_DIR"
      git clone --depth 1 https://github.com/NvChad/NvChad "$NVIM_DIR"
    else
      # Lightweight update (fast-forward only)
      echo "[nvchad] updating existing NvChad repo" >&2
      git -C "$NVIM_DIR" pull --ff-only || true
    fi
  '';

  # Provide a themed custom config layer (chadrc + highlights) leveraging central palette.
  home.file."${config.xdg.configHome}/nvim/lua/custom/chadrc.lua".text = ''
    local M = {}
    M.ui = {
      theme = "catppuccin",
      theme_toggle = { "catppuccin", "catppuccin" },
      transparency = false,
    }
    -- Pass flavour to catppuccin via plugin override (see plugins.lua)
    M.mappings = {}
    return M
  '';

  home.file."${config.xdg.configHome}/nvim/lua/custom/plugins.lua".text = ''
    return {
      {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
          require("catppuccin").setup({
            flavour = "${flavor}",
            integrations = {
              treesitter = true,
              telescope = true,
              gitsigns = true,
              cmp = true,
              notify = true,
              which_key = true,
              nvimtree = true,
              mason = true,
              navic = { enabled = true },
            }
          })
          vim.cmd.colorscheme "catppuccin"
        end
      },
    }
  '';

  # Expose a helper file converting palette into lua for custom highlights.
  home.file."${config.xdg.configHome}/nvim/lua/custom/palette.lua".text = let p = my.theme.palette; in ''
    return {
      base = "${p.base}", mantle = "${p.mantle}", crust = "${p.crust}",
      surface0 = "${p.surface0}", surface1 = "${p.surface1}", surface2 = "${p.surface2}",
      text = "${p.text}", subtext0 = "${p.subtext0}", subtext1 = "${p.subtext1}",
      lavender = "${p.lavender}", blue = "${p.blue}", sapphire = "${p.sapphire}", sky = "${p.sky}",
      teal = "${p.teal}", green = "${p.green}", yellow = "${p.yellow}", peach = "${p.peach}",
      maroon = "${p.maroon}", red = "${p.red}", mauve = "${p.mauve}", pink = "${p.pink}",
      flamingo = "${p.flamingo}", rosewater = "${p.rosewater}" }
  '';
}
