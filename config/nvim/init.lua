-- ~/.config/nvim/init.lua
-- Neovim starter-kit with:
--   • FZF-powered file switcher (⌘O / Ctrl-Shift-O / <leader>o)
--   • Treesitter syntax highlighting for TS/JS, Bash, Swift, Java …
--   • Tokyo Night colorscheme

-------------------------------------------------------------
-- 0.  Leader key — set *first* so all later mappings inherit
-------------------------------------------------------------
vim.g.mapleader = " "   -- Space as <leader>

-------------------------------------------------------------
-- 1.  Bootstrap lazy.nvim (plugin manager)
-------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------
-- 2.  Plugins
-------------------------------------------------------------
require("lazy").setup({
  -- FZF core + vim integration -----------------------------
  { "junegunn/fzf",        build = ":call fzf#install()" },
  { "junegunn/fzf.vim" },

  -- Treesitter for rich syntax-aware highlighting ------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash", "javascript", "typescript",
        "swift", "java",
        -- extras ------------------------------------------
        "lua", "vim", "json", "query",
      },
      auto_install = true,         -- auto-grab missing parsers
      highlight     = { enable = true },
      indent        = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Tokyo Night colorscheme ---------------------------------
  {
    "folke/tokyonight.nvim",
    opts = { style = "storm" },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },
})

-------------------------------------------------------------
-- 3.  Core options (feel free to tweak) ---------------------
-------------------------------------------------------------
vim.o.termguicolors   = true
vim.opt.number         = true    -- show absolute line numbers
vim.opt.relativenumber = true    -- show relative line numbers
vim.o.timeoutlen       = 500     -- ms for <leader> timing

-------------------------------------------------------------
-- 4.  Key-mappings -----------------------------------------
-------------------------------------------------------------
-- FZF file switcher
vim.keymap.set("n", "<D-o>",   ":Files<CR>", { noremap=true, silent=true, desc="FZF file switcher (⌘O)" })
vim.keymap.set("n", "<C-S-o>", ":Files<CR>", { noremap=true, silent=true, desc="FZF file switcher (Ctrl-Shift-O)" })
vim.keymap.set("n", "<leader>o", ":Files<CR>", { noremap=true, silent=true, desc="FZF file switcher (<leader>o)" })

-- Better paste in visual mode
vim.keymap.set("x", "p", "\"_dP", { noremap=true, silent=true, desc="Paste over without yanking replaced text" })

-- Center cursor after half-page scrolls
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap=true, silent=true, desc="Half-page down & center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap=true, silent=true, desc="Half-page up & center" })

-------------------------------------------------------------
-- 5.  After install: open Neovim and run :Lazy sync ---------
-------------------------------------------------------------
-- Treesitter parsers auto-compile. To add languages later:
--   :TSInstall <lang> or :TSUpdate

