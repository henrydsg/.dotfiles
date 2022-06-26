vim.cmd [[let $FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"]]
vim.cmd [[let $BAT_THEME="Dracula"]]

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap("n", "<Space>t", ":Files<CR>", opts)
