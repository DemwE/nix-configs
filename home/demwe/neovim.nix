{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # Manually manage neovim config
  home.file.".config/nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "NvChad";
      tag = "v2.5";
      sha256 = "sha256-U81M3RFMP7jKirxj3ROCsyqTRXGCrtN6VsPrewlPSLI=";
    };
    recursive = true;
  };

  # Override the init.lua file with custom configuration
  home.file.".config/nvim/init.lua" = {
    text = ''
      vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
      vim.g.mapleader = " "

      -- bootstrap lazy and all plugins
      local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

      if not vim.uv.fs_stat(lazypath) then
        local repo = "https://github.com/folke/lazy.nvim.git"
        vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
      end

      vim.opt.rtp:prepend(lazypath)

      local lazy_config = require "configs.lazy"

      -- load plugins
      require("lazy").setup({
        {
          "NvChad/NvChad",
          lazy = false,
          branch = "v2.5",
          import = "nvchad.plugins",
        },

        { import = "plugins" },
      }, lazy_config)

      -- load theme
      dofile(vim.g.base46_cache .. "defaults")
      dofile(vim.g.base46_cache .. "statusline")

      require "options"
      require "autocmds"

      vim.schedule(function()
        require "mappings"
      end)
    '';
  };
}
