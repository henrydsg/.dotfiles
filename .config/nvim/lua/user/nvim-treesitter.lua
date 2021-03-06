local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = "all",
  ignore_install = { "phpdoc" }, -- It seems that a bug pops up installing phpdoc.
  sync_install = false,
  indent = { enable = false, disable = { "yaml" } },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
})
