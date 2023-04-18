local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("n", "<S-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<S-k>", "<Esc>:m .-2<CR>==", opts)

-- Quick save
keymap("n", "<C-s>", "<Esc>:w<CR>", opts)

-- Path related
keymap("n", "<Space>cd", "<cmd>cd %:p:h<CR>", opts)
keymap("n", "<Space>cp", '<cmd>let @+ = expand("%")<CR>', opts)

-- use 0 register to overwrite highlighted character
keymap("n", "<Space>p", 'v"_dP', opts)

-- Insert
-- keymap("i", "jk", "<Esc>", opts)

-- Visual --
-- Move text up and down
keymap("v", "<S-j>", ":m .+1<CR>v", opts)
keymap("v", "<S-k>", ":m .-2<CR>v", opts)

-- replace all matches of selected string in current buffer
keymap("v", "<C-r>", '"hy:%s/<C-r>h//g<Left><Left>', opts)

-- use 0 register to overwrite selected block
keymap("v", "<Space>p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<S-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<S-k>", ":move '<-2<CR>gv=gv", opts)

-- Stay in indent mode
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)

