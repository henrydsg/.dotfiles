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
    requires = { { "L3MON4D3/LuaSnip" } },
  })

  use({
    "hrsh7th/cmp-buffer",
    requires = "nvim-cmp"
  })

  use({
    "hrsh7th/cmp-path",
    requires = "nvim-cmp"
  })

  -- LSP
  use({
    "williamboman/nvim-lsp-installer",
    config = "require 'user.lsp.nvim-lsp-installer'",
    requires = {
      {
        "neovim/nvim-lspconfig",
        config = "require 'user.lsp.nvim-lspconfig'.setup()"
      },
      {
        -- Augment auto-comletion with LSP
        "hrsh7th/cmp-nvim-lsp",
        requires = "hrsh7th/nvim-cmp"
      }
    },
  })

  -- tree-sitter
  use({
    "nvim-treesitter/nvim-treesitter",
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
