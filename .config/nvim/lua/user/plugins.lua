local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Plug plugins here
  use "wbthomason/packer.nvim"

  -- Auto-completion
  use({
    "hrsh7th/nvim-cmp",
    config = "require 'user.cmp.nvim-cmp'",
    requires = {
      {
        "L3MON4D3/LuaSnip",
        requires = {
          "rafamadriz/friendly-snippets",
          "saadparwaiz1/cmp_luasnip"
        },
      }
    },
  })

  use({
    "hrsh7th/cmp-buffer",
    requires = "nvim-cmp"
  })

  use({
    "hrsh7th/cmp-path",
    requires = "nvim-cmp"
  })

  use({
    "hrsh7th/cmp-omni",
    requires = "nvim-cmp"
  })

  use({
    "windwp/nvim-autopairs",
    requires = "nvim-cmp",
    config = "require 'user.autopairs'",
  })

  -- LSP
  use {
    "williamboman/mason.nvim",
    config = "require 'mason'.setup()",
    requires = {
      {
        "neovim/nvim-lspconfig",
        config = "require 'user.lsp.nvim-lspconfig'.setup()"
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = "require 'mason-lspconfig'.setup()"
      },
      {
        -- Augment auto-comletion with LSP
        "hrsh7th/cmp-nvim-lsp",
        requires = "hrsh7th/nvim-cmp"
      }
    },
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }

  -- tree-sitter
  use({
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    run = ":TSUpdate",
    config = "require 'user.nvim-treesitter'"
  })

  -- fzf
  use({
    "junegunn/fzf.vim",
    requires = {
      {
        "junegunn/fzf",
        run = ":call fzf#install()",
      }
    },
    config = "require 'user.fzf'"
  })

  -- commentary
  use({
    "JoosepAlviste/nvim-ts-context-commentstring"
  })

  use({
    "numToStr/Comment.nvim",
    requires = "nvim-ts-context-commentstring",
    config = "require 'user.comment'"
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
